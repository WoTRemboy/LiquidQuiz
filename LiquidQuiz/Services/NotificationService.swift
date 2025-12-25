//
//  NotificationService.swift
//  LiquidQuiz
//
//  Created by Roman Tverdokhleb on 25/12/2025.
//

import Foundation
import Combine
import UserNotifications
import UIKit

/// A service responsible for managing User Notifications authorization state and requests.
protocol NotificationServicing: AnyObject {
    var currentAuthorizationStatus: UNAuthorizationStatus { get }
    var isAccessGranted: Bool { get }
    func refreshAuthorizationStatus()
    func requestAuthorization(options: UNAuthorizationOptions) async -> UNAuthorizationStatus
    func openAppSettings()
}

@MainActor
final class NotificationService: ObservableObject, NotificationServicing {
    static let shared = NotificationService()

    private let center: UNUserNotificationCenter
    
    @Published private(set) var authorizationStatus: UNAuthorizationStatus = .notDetermined

    var currentAuthorizationStatus: UNAuthorizationStatus {
        authorizationStatus
    }

    var isAccessGranted: Bool {
        switch authorizationStatus {
        case .authorized, .provisional, .ephemeral:
            return true
        default:
            return false
        }
    }

    private init(center: UNUserNotificationCenter = .current()) {
        self.center = center
        refreshAuthorizationStatus()
    }

    func refreshAuthorizationStatus() {
        center.getNotificationSettings { [weak self] settings in
            Task { @MainActor in
                self?.authorizationStatus = settings.authorizationStatus
            }
        }
    }

    func requestAuthorization(options: UNAuthorizationOptions = [.alert, .badge, .sound]) async -> UNAuthorizationStatus {
        _ = try? await center.requestAuthorization(options: options)
        await withCheckedContinuation { (continuation: CheckedContinuation<Void, Never>) in
            center.getNotificationSettings { [weak self] settings in
                Task { @MainActor in
                    self?.authorizationStatus = settings.authorizationStatus
                    continuation.resume()
                }
            }
        }
        return currentAuthorizationStatus
    }

    func openAppSettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
