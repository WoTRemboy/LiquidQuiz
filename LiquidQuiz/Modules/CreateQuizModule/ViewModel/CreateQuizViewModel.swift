//
//  CreateQuizViewModel.swift
//  LiquidQuiz
//
//  Created by Roman Tverdokhleb on 13/06/2025.
//

import SwiftUI
import Combine

final class CreateQuizViewModel: ObservableObject {
    
    // MARK: - Quiz Topic
    
    @Published internal var quizTopic: String = String()
    
    internal var isQuizTopicEmpty: Bool {
        quizTopic.isEmpty
    }
    
    internal func setQuizTopic(_ topic: String = String(), random: Bool = false) {
        if random, let randomTopic = MockTopic.allCases.randomElement() {
            quizTopic = randomTopic.rawValue
        } else {
            quizTopic = topic
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
    
    @Published internal var quizDifficulty: Quiz.Difficulty = .normal
    
    internal func setQuizDifficulty(to difficulty: Quiz.Difficulty) {
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
