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
    
    internal var quizCorrectAnswers: Int {
        Int((Float(quiz.correctAnswers) / Float(totalQuestions)) * 100)
    }
    
    // MARK: - Selected Answer
        
    internal func isSelectedAnswerEmpty(for question: QuizQuestion) -> Bool {
        question.selectedAnswer == nil
    }
    
    internal func setSelectedAnswer(answer: QuizOption) {
        quiz.questions[quiz.currentQuestionIndex].setSelectedAnswer(answer)
        
        if let selectedAnswer = currentQuestion.selectedAnswer, selectedAnswer.isCorrect {
            increaseScore(in: currentQuestion.price)
            quiz.increaseCorrectAnswers()
        }
    }
    
    internal func optionColor(question: QuizQuestion, currentOption: QuizOption) -> Color {
        guard let selectedAnswer = question.selectedAnswer else { return .clear }
        
        guard currentOption == selectedAnswer || currentOption.isCorrect else { return .gray.opacity(0.2) }
        return currentOption.isCorrect ? .green.opacity(0.3) : .red.opacity(0.3)
    }
    
    internal func sensoryFeedback(currentOption: QuizOption) -> SensoryFeedback {
        return currentOption.isCorrect ? .impact : .warning
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
    
    internal var isLastQuestion: Bool {
        currentQuestionIndex + 1 == totalQuestions
    }
    
    internal var quizProgress: Double {
        guard totalQuestions > 0 else { return 0 }
        let answered = currentQuestion.selectedAnswer != nil ? 1 : 0
        
        return Double(quiz.currentQuestionIndex + answered) / Double(totalQuestions)
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
    
    // MARK: - Quiz Result Page Score
    
    @Published internal var timer: Timer? = nil
    @Published internal var percent: Int = 0
    
    @Published internal var isShowingResultContent: Bool = false
    
    internal func scoreIncreasing() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { 
            self.timer?.invalidate()
            self.timer = Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { [weak self] timer in
                guard let self = self else {
                    timer.invalidate()
                    return
                }
                
                if self.percent < self.quizCorrectAnswers {
                    withAnimation(.linear(duration: 0.02)) {
                        self.percent += 1
                    }
                } else {
                    timer.invalidate()
                    self.timer = nil
                    withAnimation(.spring(duration: 0.3)) {
                        self.isShowingResultContent.toggle()
                    }
                }
            }
        }
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

extension QuizViewModel: Equatable, Hashable {
    static func == (lhs: QuizViewModel, rhs: QuizViewModel) -> Bool {
        lhs === rhs
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
}

