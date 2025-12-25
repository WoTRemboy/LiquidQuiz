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

final class OnboardingViewModel: ObservableObject {
    
    private var cancellables = Set<AnyCancellable>()
    
    @AppStorage(Texts.UserDefaults.skipOnboarding) var skipOnboarding: Bool = false
    @Published internal var steps = OnboardingStep.stepsSetup()
    @Published internal var currentStep = 0

    @Published internal var notificationsGranted: Bool = true
    @Published internal var showNotificationsPermissionAlert: Bool = false

    
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
            return .getNotificationPermission(access: .authorized)
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
                externalAction()
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
}
