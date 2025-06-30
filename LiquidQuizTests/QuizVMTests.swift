//
//  QuizVMTests.swift
//  LiquidQuiz
//
//  Created by Roman Tverdokhleb on 30/06/2025.
//

import Testing
import SwiftUI
@testable import LiquidQuiz

@Suite("QuizViewModel Behavior")
struct QuizViewModelTests {
    
    @Test("Initialization binds quiz and timer")
    func testInitialState() async throws {
        let quiz = await Quiz.sampleData
        let viewModel = await QuizViewModel(quiz: quiz)
        #expect(viewModel.quiz == quiz)
        #expect(viewModel.remainingTime == quiz.timer)
    }
    
    @Test("Selecting a correct answer increases score and correct count")
    func testSelectCorrectAnswer() async throws {
        let quiz = await Quiz.sampleData
        let correctOption = await quiz.questions[0].options.first(where: { $0.isCorrect })!
        let viewModel = await QuizViewModel(quiz: quiz)
        let initialScore = await viewModel.quizScore
        let initialCorrect = await viewModel.quiz.correctAnswers
        await viewModel.setSelectedAnswer(answer: correctOption)
        
        #expect(viewModel.quizScore > initialScore)
        await #expect(viewModel.quiz.correctAnswers == initialCorrect + 1)
        await #expect(viewModel.currentQuestion.selectedAnswer == correctOption)
    }
    
    @Test("Selecting a wrong answer does not increase score nor correct count")
    func testSelectWrongAnswer() async throws {
        var quiz = await Quiz.sampleData
        let wrongOption = await quiz.questions[0].options.first(where: { !$0.isCorrect })!
        let viewModel = await QuizViewModel(quiz: quiz)
        let initialScore = await viewModel.quizScore
        let initialCorrect = await viewModel.quiz.correctAnswers
        await viewModel.setSelectedAnswer(answer: wrongOption)
        
        #expect(viewModel.quizScore == initialScore)
        await #expect(viewModel.quiz.correctAnswers == initialCorrect)
        await #expect(viewModel.currentQuestion.selectedAnswer == wrongOption)
    }
    
    @Test("Quiz progress updates as answers are given")
    func testQuizProgress() async throws {
        let quiz = await Quiz.sampleData
        let viewModel = await QuizViewModel(quiz: quiz)
        let initialProgress = await viewModel.quizProgress
        let correctOption = await viewModel.currentQuestion.options.first(where: { $0.isCorrect })!
        
        await viewModel.setSelectedAnswer(answer: correctOption)
        await #expect(viewModel.quizProgress > initialProgress)
    }

    @Test("Next question updates currentQuestionIndex and triggers action at end")
    func testNextQuestionLogic() async throws {
        let quiz = await Quiz.sampleData
        let viewModel = await QuizViewModel(quiz: quiz)
        let correctOption = await viewModel.currentQuestion.options.first(where: { $0.isCorrect })!
        await viewModel.setSelectedAnswer(answer: correctOption)
        var didCallAction = false
        await viewModel.nextQuestion { didCallAction = true }
        
        if await viewModel.isLastQuestion {
            #expect(didCallAction)
        } else {
            #expect(!didCallAction)
        }
    }

    @Test("Dialog and popover toggles work")
    func testDialogPopoverToggles() async throws {
        let quiz = await Quiz.sampleData
        let viewModel = await QuizViewModel(quiz: quiz)
        #expect(!viewModel.isShowingResetDialog)
        
        await viewModel.isShowingResetDialogToggle()
        #expect(viewModel.isShowingResetDialog)
        #expect(!viewModel.isShowingHintPopover)
        
        await viewModel.isShowingHintPopoverToggle()
        #expect(viewModel.isShowingHintPopover)
    }
}
