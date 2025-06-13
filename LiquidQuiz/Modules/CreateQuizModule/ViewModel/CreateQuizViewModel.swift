//
//  CreateQuizViewModel.swift
//  LiquidQuiz
//
//  Created by Roman Tverdokhleb on 13/06/2025.
//

import SwiftUI
import Combine

final class CreateQuizViewModel: ObservableObject {
    
    // MARK: - Quiz Theme
    
    @Published internal var quizTheme: String = String()
    
    internal var isQuizThemeEmpty: Bool {
        quizTheme.isEmpty
    }
    
    internal func setQuizTheme(_ theme: String = String(), random: Bool = false) {
        if random, let randomTheme = MockTheme.allCases.randomElement() {
            quizTheme = randomTheme.rawValue
        } else {
            quizTheme = theme
        }
    }
    
    // MARK: - Questions Count
    
    @Published internal var quizQuestions: [QuizQuestion] = QuizQuestion.sampleData
    @Published internal var questionCount: Double = 10.0
    
    internal var totalQuestions: Int {
        quizQuestions.count
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
    
    // MARK: - Quiz Difficulty
    
    @Published internal var quizDifficulty: QuizDifficulty = .normal
    
    internal func setQuizDifficulty(to difficulty: QuizDifficulty) {
        quizDifficulty = difficulty
        isDifficultyExpandedToggle()
    }
    
    // MARK: - Questions Count Slider Expanded
    
    @Published internal var isSliderExpanded: Bool = false
    
    internal func isSliderExpandedToggle() {
        isSliderExpanded.toggle()
        isDifficultyExpanded = false
    }
    
    // MARK: - Difficulty Picker Expanded
    
    @Published internal var isDifficultyExpanded: Bool = false
    
    internal func isDifficultyExpandedToggle() {
        isDifficultyExpanded.toggle()
        isSliderExpanded = false
    }
}
