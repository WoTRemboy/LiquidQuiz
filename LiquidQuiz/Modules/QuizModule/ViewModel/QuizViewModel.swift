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
    
    @Published internal var selectedAnswer: String = String()
    
    internal var isSelectedAnswerEmpty: Bool {
        selectedAnswer.isEmpty
    }
    
    internal func setSelectedAnswer(to answer: String) {
        selectedAnswer = answer
    }
    
    internal func optionColor(current: String, correct: String) -> Color {
        guard !isSelectedAnswerEmpty else { return .clear }
        
        guard current == selectedAnswer || current == correct else { return .gray.opacity(0.2) }
        return current == correct ? .green.opacity(0.3) : .red.opacity(0.3)
    }
    
    // MARK: - Quiz Theme
    
    @Published internal var quizTheme: String = "Appartments"
    
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
    
    // MARK: - Quiz Quiestions
    
    @Published internal var quizQuestions: [QuizQuestion] = QuizQuestion.sampleData
    @Published internal var currentQuestionIndex: Int = 0
    
    internal var currentQuestionNumber: Int {
        currentQuestionIndex + 1
    }
    
    internal var quizProgress: Double {
        guard totalQuestions > 0 else { return 0 }
        return Double(currentQuestionIndex + 1) / Double(totalQuestions)
    }
    
    // MARK: - Quiz Score
    
    @Published internal var quizScore: Int = 0
    
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
    
    // MARK: - Quiz Reset Dialog
    
    @Published internal var isShowingResetDialog: Bool = false
    
    internal func isShowingResetDialogToggle() {
        isShowingResetDialog.toggle()
    }
}
