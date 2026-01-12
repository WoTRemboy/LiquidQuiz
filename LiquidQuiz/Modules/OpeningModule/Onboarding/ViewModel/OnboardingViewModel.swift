//
//  OnboardingViewModel.swift
//  LiquidQuiz
//
//  Created by Roman Tverdokhleb on 25/12/2025.
//

import Foundation
import SwiftUI
import Combine
import UserNotifications

@MainActor
final class OnboardingViewModel: ObservableObject {
    
    private var cancellables = Set<AnyCancellable>()
    private let notificationService = NotificationService.shared
    
    @AppStorage(Texts.UserDefaults.skipOnboarding) var skipOnboarding: Bool = false
    @Published internal var steps = OnboardingStep.stepsSetup()
    @Published internal var currentStep = 0

    @Published internal var notificationAuthorizationStatus: UNAuthorizationStatus = .notDetermined
    @Published internal var notificationsGranted: Bool = true
    @Published internal var showNotificationsPermissionAlert: Bool = false

    init() {
        notificationService.$authorizationStatus
            .receive(on: DispatchQueue.main)
            .assign(to: \OnboardingViewModel.notificationAuthorizationStatus, on: self)
            .store(in: &cancellables)
        
        notificationService.$authorizationStatus
            .sink { [weak self] status in
                guard let self else { return }
                self.notificationsGranted = (status == .authorized || status == .provisional || status == .ephemeral)
                withAnimation {
                    self.steps[3].grantedAccess = self.notificationsGranted
                }
            }
            .store(in: &cancellables)

        notificationService.refreshAuthorizationStatus()
        setupAppLifecycleObservers()
    }
    
    deinit {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
    }
    
    // MARK: - Computed Properties
    
    /// Pages for the onboarding process.
    internal var pages: [Int] {
        Array(0..<steps.count)
    }
    
    internal var isLastPage: Bool {
        currentStep == steps.count - 1
    }
    
    internal var buttonType: OnboardingButtonType {
        if currentStep < steps.count - 1 {
            return .nextPage
        } else {
            let status = notificationAuthorizationStatus
            return .getNotificationPermission(access: status)
        }
    }
    
    internal var showSkipButton: Bool {
        currentStep >= steps.count - 1 && !steps[currentStep].grantedAccess
    }
    
    internal func setupCurrentStep(newValue: Int) {
        currentStep = newValue
    }
    
    internal func transferToMainPage() {
        skipOnboarding.toggle()
    }
    
    /// Draws the "drawOn" symbol effect asynchronously for the given page index.
    internal func drawOnSymbol(_ index: Int) async {
        try? await Task.sleep(for: .seconds(0.2))
        steps[index].drawOn = true
    }
    
    /// Starts a new asynchronous task to trigger the drawOnSymbol function.
    internal func triggerDrawOnSymbol(_ index: Int) {
        Task {
            await drawOnSymbol(index)
        }
    }
    
    internal func handleActionButtonTap(externalAction: @escaping () -> Void) {
        switch buttonType {
        case .nextPage:
            withAnimation { externalAction() }
        case .getNotificationPermission(let access):
            switch access {
            case .authorized, .provisional, .ephemeral:
                withAnimation { self.transferToMainPage() }
            case .notDetermined:
                Task { [weak self] in
                    guard let self else { return }
                    let _ = await self.notificationService.requestAuthorization(options: [.alert, .badge, .sound])
                }
            default:
                showNotificationsPermissionAlert.toggle()
            }
        }
    }
    
    internal func handleSkipButtonTap(externalAction: @escaping () -> Void) {
        switch buttonType {
        case .getNotificationPermission:
            withAnimation { self.transferToMainPage() }
        default:
            withAnimation { externalAction() }
        }
    }
    
    internal func openSettings() {
        notificationService.openAppSettings()
    }
    
    // MARK: - App Lifecycle Observers

    private func setupAppLifecycleObservers() {
        NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)
            .sink { [weak self] _ in
                self?.notificationService.refreshAuthorizationStatus()
            }
            .store(in: &cancellables)
        
        NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)
            .sink { [weak self] _ in
                self?.notificationService.refreshAuthorizationStatus()
            }
            .store(in: &cancellables)
    }
}
