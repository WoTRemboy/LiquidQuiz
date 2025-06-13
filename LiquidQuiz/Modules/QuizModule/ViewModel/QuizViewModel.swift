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
    
    // MARK: - Quiz Data
    
    internal let quiz: [QuizQuestion]
    
    init(quiz: [QuizQuestion]) {
        self.quiz = quiz
    }
    
    // MARK: - Selected Answer
    
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
    
    // MARK: - Quiz Quiestions
    
    @Published internal var quizQuestions: [QuizQuestion] = QuizQuestion.sampleData
    @Published internal var currentQuestionIndex: Int = 0
    
    internal var totalQuestions: Int {
        quizQuestions.count
    }
    
    internal var currentQuestionNumber: Int {
        currentQuestionIndex + 1
    }
    
    internal var quizProgress: Double {
        guard totalQuestions > 0 else { return 0 }
        return Double(currentQuestionIndex + 1) / Double(totalQuestions)
    }
    
    // MARK: - Quiz Score
    
    @Published internal var quizScore: Int = 0
    
    // MARK: - Quiz Reset Dialog
    
    @Published internal var isShowingResetDialog: Bool = false
    
    internal func isShowingResetDialogToggle() {
        isShowingResetDialog.toggle()
    }
    
    // MARK: - Hint Popover
    
    @Published internal var isShowingHintPopover: Bool = false
    
    internal func isShowingHintPopoverToggle() {
        isShowingHintPopover.toggle()
    }
}
