//
//  OnboardingGradientModel.swift
//  LiquidQuiz
//
//  Created by Roman Tverdokhleb on 16/07/2025.
//

import SwiftUI

enum OnboardingPage: Int8 {
    case welcome = 8
    case first = 0
    case second = 1
    case third = 2
    case fourth = 3
    case fifth = 4
    
    internal var points: [SIMD2<Float>] {
        switch self {
        case .welcome:
            [[0.0, 0.0], [0.5, 0.0], [1.0, 0.0],
            [0.0, 0.2], [0.5, 0.5], [1.0, 1.0],
            [0.0, 1.0], [0.5, 1.0], [1.0, 1.0]]
            
        case .first:
            [[0.0, 0.0], [0.5, 0.0], [1.0, 0.0],
            [0.0, 0.7], [0.5, 0.5], [1.0, 1.0],
            [0.0, 1.0], [0.5, 1.0], [1.0, 1.0]]
            
        case .second, .third, .fourth:
            [[0.0, 0.0], [0.5, 0.0], [1.0, 0.0],
             [0.0, 0.5], [0.5, 0.5], [1.0, 0.5],
             [0.0, 1.0], [0.5, 1.0], [1.0, 1.0]]

        case .fifth:
            [[0.0, 0.0], [0.5, 0.0], [1.0, 0.0],
             [0.0, 0.4], [0.5, 0.5], [1.0, 0.6],
             [0.0, 1.0], [0.5, 1.0], [1.0, 1.0]]
        }
    }
    
    internal var colors: [Color] {
        switch self {
        case .welcome:
            [.Gradient.Onboarding.purple,
             .Gradient.Onboarding.purple,
             .Gradient.Onboarding.purple,
             
             .Gradient.Onboarding.orange,
             .Gradient.Onboarding.purple,
             .Gradient.Onboarding.red,
             
             .Gradient.Onboarding.purple,
             .Gradient.Onboarding.purple,
             .Gradient.Onboarding.purple]
            
        case .first:
            [.Gradient.Onboarding.purple,
             .Gradient.Onboarding.orange,
             .Gradient.Onboarding.purple,

             .Gradient.Onboarding.purple,
             .Gradient.Onboarding.purple,
             .Gradient.Onboarding.purple,

             .Gradient.Onboarding.red,
             .Gradient.Onboarding.purple,
             .Gradient.Onboarding.purple]
            
        case .second:
            [.Gradient.Onboarding.purple,
             .Gradient.Onboarding.purple,
             .Gradient.Onboarding.orange,
             
             .Gradient.Onboarding.red,
             .Gradient.Onboarding.purple,
             .Gradient.Onboarding.purple,
             
             .Gradient.Onboarding.purple,
             .Gradient.Onboarding.purple,
             .Gradient.Onboarding.purple]
            
        case .third:
            [.Gradient.Onboarding.red,
             .Gradient.Onboarding.red,
             .Gradient.Onboarding.purple,
             
             .Gradient.Onboarding.purple,
             .Gradient.Onboarding.purple,
             .Gradient.Onboarding.orange,
             
             .Gradient.Onboarding.purple,
             .Gradient.Onboarding.purple,
             .Gradient.Onboarding.purple]
            
        case .fourth:
            [.Gradient.Onboarding.purple,
             .Gradient.Onboarding.purple,
             .Gradient.Onboarding.purple,
             
             .Gradient.Onboarding.purple,
             .Gradient.Onboarding.purple,
             .Gradient.Onboarding.red,
             
             .Gradient.Onboarding.orange,
             .Gradient.Onboarding.purple,
             .Gradient.Onboarding.purple]
            
        case .fifth:
            [.Gradient.Onboarding.orange,
             .Gradient.Onboarding.orange,
             .Gradient.Onboarding.purple,

             .Gradient.Onboarding.purple,
             .Gradient.Onboarding.purple,
             .Gradient.Onboarding.purple,

             .Gradient.Onboarding.purple,
             .Gradient.Onboarding.red,
             .Gradient.Onboarding.red]
        }
    }
}
