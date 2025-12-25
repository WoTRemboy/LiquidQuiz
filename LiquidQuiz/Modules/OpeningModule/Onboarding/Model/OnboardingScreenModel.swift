//
//  OnboardingScreenModel.swift
//  LiquidQuiz
//
//  Created by Roman Tverdokhleb on 25/12/2025.
//

import SwiftUI
import UserNotifications

struct OnboardingStep {
    let name: String
    let description: String
    let image: Image
    var drawOn: Bool = false
    var grantedAccess: Bool = false
}

extension OnboardingStep {
    static func stepsSetup() -> [OnboardingStep] {
        let first = OnboardingStep(
            name: Texts.OnboardingPage.FirstPage.title,
            description: Texts.OnboardingPage.FirstPage.description,
            image: .OnboardingPage.first
        )
        
        let second = OnboardingStep(
            name: Texts.OnboardingPage.SecondPage.title,
            description: Texts.OnboardingPage.SecondPage.description,
            image: .OnboardingPage.second
        )
        
        let third = OnboardingStep(
            name: Texts.OnboardingPage.ThirdPage.title,
            description: Texts.OnboardingPage.ThirdPage.description,
            image: .OnboardingPage.third
        )
        
        let fourth = OnboardingStep(
            name: Texts.OnboardingPage.FourthPage.title,
            description: Texts.OnboardingPage.FourthPage.description,
            image: .OnboardingPage.fourth,
            grantedAccess: true
        )
        
        return [first, second, third, fourth]
    }
}


enum OnboardingButtonType: Equatable {
    case nextPage
    case getNotificationPermission(access: UNAuthorizationStatus)
    
    internal var title: String {
        switch self {
        case .nextPage:
            return Texts.OnboardingPage.next
            
        case .getNotificationPermission(let access):
            switch access {
            case .notDetermined:
                return Texts.OnboardingPage.permission
            case .authorized, .provisional, .ephemeral:
                return Texts.OnboardingPage.begin
            default:
                return Texts.OnboardingPage.forbidden
            }
        }
    }
    
    internal var showSkipButton: Bool {
        switch self {
        case .nextPage:
            return false
        case .getNotificationPermission:
            return true
        }
    }
    
    static func == (lhs: OnboardingButtonType, rhs: OnboardingButtonType) -> Bool {
        return lhs.title == rhs.title
    }
}


