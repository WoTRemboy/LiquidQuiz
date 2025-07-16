//
//  OnboardingScreenModel.swift
//  LiquidQuiz
//
//  Created by Roman Tverdokhleb on 16/07/2025.
//

import SwiftUI

// MARK: - Onboarding Step Model

/// Represents a step in the onboarding process, including title, description, and image.
struct OnboardingStep {
    /// Title of the onboarding step.
    let name: String
    /// Description of what this step covers.
    let description: String
    /// Image associated with this onboarding step.
    let image: Image
    
    let type: OnboardingPage
}

// MARK: - Onboarding Step Setup

extension OnboardingStep {
    
    /// Configures and returns the list of onboarding steps.
    /// - Returns: An array of `OnboardingStep` instances, each representing a step in the onboarding process.
    static func stepsSetup() -> [OnboardingStep] {
        let first = OnboardingStep(name: Texts.Onboarding.FirstPage.title,
                                   description: Texts.Onboarding.FirstPage.description,
                                   image: .Onboarding.first,
                                   type: .first)
        
        let second = OnboardingStep(name: Texts.Onboarding.SecondPage.title,
                                    description: Texts.Onboarding.SecondPage.description,
                                    image: .Onboarding.second,
                                    type: .second)
        
        let third = OnboardingStep(name: Texts.Onboarding.ThirdPage.title,
                                   description: Texts.Onboarding.ThirdPage.description,
                                   image: .Onboarding.third,
                                   type: .third)
        
        let fourth = OnboardingStep(name: Texts.Onboarding.FourthPage.title,
                                    description: Texts.Onboarding.FourthPage.description,
                                    image: .Onboarding.fourth,
                                    type: .fourth)
        
        let fifth = OnboardingStep(name: Texts.Onboarding.FifthPage.title,
                                   description: Texts.Onboarding.FifthPage.description,
                                   image: .Onboarding.fifth,
                                   type: .fifth)
        
        return [first, second, third, fourth, fifth]
    }
}

// MARK: - Onboarding Button Type

/// Enum defining types of buttons in the onboarding screen.
enum OnboardingButtonType {
    /// Button that navigates to the next onboarding step.
    case nextPage
    /// Button that completes onboarding and starts the app.
    case getStarted
}
