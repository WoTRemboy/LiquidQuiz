//
//  OnboardingViewModel.swift
//  LiquidQuiz
//
//  Created by Roman Tverdokhleb on 17/07/2025.
//

import Foundation
import Combine
import SwiftUI

final class OnboardingViewModel: NSObject, ObservableObject {
    
    // MARK: - Properties
    
    /// A flag indicating if onboarding should be skipped (i.e., onboarding is completed).
    @AppStorage(Keys.UserDefaults.skipOnboarding) internal var skipOnboarding: Bool = false
    @Published internal var beginOnboarding: Bool = false
    @Published internal var currentPage: OnboardingPage = .welcome
    
    /// The list of onboarding steps, initialized using `stepsSetup()`.
    private(set) var steps = OnboardingStep.stepsSetup()
    
    // MARK: - Computed Properties
    
    /// Pages for the onboarding process.
    internal var pages: [Int] {
        Array(0..<steps.count)
    }
    
    // MARK: - Methods
    
    internal func toggleBeginOnboarding() {
        beginOnboarding.toggle()
        currentPage = .first
    }
    
    internal func currentGradientPage(index: Int) -> OnboardingPage {
        if !beginOnboarding {
            return .welcome
        }
        return OnboardingPage(rawValue: Int8(index)) ?? .first
    }
    
    /// Determines if the given page index corresponds to the last onboarding page.
    /// - Parameter current: The current page index.
    /// - Returns: `true` if the current page is the last; otherwise, `false`.
    internal func isLastPage(current: Int) -> Bool {
        current == steps.count - 1
    }
    
    /// Skips directly to the final onboarding step with a smooth animation.
    internal func transferToMainPage() {
        withAnimation(.easeInOut) {
            skipOnboarding.toggle()
        }
    }
}
