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
    
    @Published internal var quiz: Quiz
    
    init(quiz: Quiz) {
        self.quiz = quiz
    }
    
    internal var currentQuestion: QuizQuestion {
        quiz.questions[currentQuestionIndex]
    }
    
    // MARK: - Selected Answer
        
    internal func isSelectedAnswerEmpty(for question: QuizQuestion) -> Bool {
        question.selectedAnswer == nil
    }
    
    internal func setSelectedAnswer(to question: QuizQuestion, answer: QuizOption) {
        quiz.questions[quiz.currentQuestionIndex].selectedAnswer = answer
        
        if let selectedAnswer = question.selectedAnswer, selectedAnswer.isCorrect {
            increaseScore(in: currentQuestion.price)
        }
    }
    
    internal func optionColor(question: QuizQuestion, currentOption: QuizOption) -> Color {
        guard let selectedAnswer = question.selectedAnswer else { return .clear }
        
        guard currentOption == selectedAnswer || currentOption.isCorrect else { return .gray.opacity(0.2) }
        return currentOption.isCorrect ? .green.opacity(0.3) : .red.opacity(0.3)
    }
    
    internal func showExplanation(for question: QuizQuestion, option: QuizOption) -> Bool {
        guard question.selectedAnswer != nil else { return false }
        return option.isCorrect
    }
    
    // MARK: - Quiz Quiestions
    
    private var currentQuestionIndex: Int {
        quiz.currentQuestionIndex
    }
        
    private var totalQuestions: Int {
        quiz.questions.count
    }
    
    private var isLastQuestion: Bool {
        currentQuestionIndex + 1 == totalQuestions
    }
    
    internal var quizProgress: Double {
        guard totalQuestions > 0 else { return 0 }
        return Double(quiz.currentQuestionIndex + 1) / Double(totalQuestions)
    }
    
    internal var nextQuestionColor: Color {
        if currentQuestion.selectedAnswer != nil {
            .green
        } else {
            .gray.opacity(0.5)
        }
    }
    
    internal func nextQuestion() {
        guard !isLastQuestion, currentQuestion.selectedAnswer != nil else { return }
        quiz.increaseQuestionIndex()
    }
    
    // MARK: - Quiz Score
    
    @Published internal var quizScore: Int = 0
    
    private func increaseScore(in value: Int) {
        quizScore += value
    }
    
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
