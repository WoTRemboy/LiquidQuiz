//
//  QuizViewModel.swift
//  LiquidQuiz
//
//  Created by Roman Tverdokhleb on 11/06/2025.
//

import Foundation
import SwiftUI
import Combine

final class QuizViewModel: ObservableObject {
    
    @Published internal var quizTheme: String = String()
    @Published internal var questionCount: Double = 10.0
    @Published internal var isSliderExpanded: Bool = false
        
    internal var isQuizThemeEmpty: Bool {
        quizTheme.isEmpty
    }
    
    internal var questionCountLabel: String {
        "\(questionCount.formatted(.number.rounded(rule: .down, increment: 1.0)))"
    }
    
    internal func questionCountRange(for range: CountRange) -> String {
        switch range {
        case .begin:
            "\(range.rawValue.formatted(.number))"
        case .end:
            "\(range.rawValue.formatted(.number))"
        }
    }
    
    internal func setQuizTheme(_ theme: String = String(), random: Bool = false) {
        if random, let randomTheme = MockTheme.allCases.randomElement() {
            quizTheme = randomTheme.rawValue
        } else {
            quizTheme = theme
        }
    }
    
    internal func isSliderExpandedToggle() {
        isSliderExpanded.toggle()
    }
}
