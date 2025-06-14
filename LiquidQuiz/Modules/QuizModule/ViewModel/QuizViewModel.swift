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
        self.remainingTime = quiz.timer
    }
    
    deinit {
        stopQuizTimer()
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
    
    internal func nextQuestion(action: () -> Void) {
        guard currentQuestion.selectedAnswer != nil else { return }
        if isLastQuestion {
            action()
        } else {
            quiz.increaseQuestionIndex()
        }
    }
    
    // MARK: - Quiz Self Timer
    
    @Published internal var remainingTime: Int
    @Published internal var isTimerFinished: Bool = false
    private var countdownTimer: Timer?
    
    internal var timeString: String {
        let minutes = remainingTime / 60
        let seconds = remainingTime % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    internal var resultTimeString: String {
        let wasted = quiz.timer - remainingTime
        let minutes = wasted / 60
        let seconds = wasted % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    internal func startQuizTimer() {
        stopQuizTimer()
        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            guard let self = self else {
                timer.invalidate()
                return
            }
            if self.remainingTime > 0 {
                self.remainingTime -= 1
            } else {
                self.isTimerFinished = true
                timer.invalidate()
                self.countdownTimer = nil
            }
        }
    }
    
    internal func stopQuizTimer() {
        countdownTimer?.invalidate()
        countdownTimer = nil
        isTimerFinished = false
    }
    
    // MARK: - Quiz Score
    
    @Published internal var quizScore: Int = 0
    
    private func increaseScore(in value: Int) {
        quizScore += value
    }
    
    // MARK: - Quiz Result Page Score
    
    @Published internal var percentCounterTimer: Timer? = nil
    @Published internal var correctAnswersPercent: Int = 0
    
    @Published internal var isShowingResultContent: Bool = false
    
    internal func scoreIncreasing() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { 
            self.percentCounterTimer?.invalidate()
            self.percentCounterTimer = Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { [weak self] timer in
                guard let self = self else {
                    timer.invalidate()
                    return
                }
                
                if self.correctAnswersPercent < self.quizCorrectAnswers {
                    withAnimation(.linear(duration: 0.02)) {
                        self.correctAnswersPercent += 1
                    }
                } else {
                    timer.invalidate()
                    self.percentCounterTimer = nil
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

