//
//  QuizModel.swift
//  LiquidQuiz
//
//  Created by Roman Tverdokhleb on 12/06/2025.
//

import Foundation
import FoundationModels

@Generable
struct Quiz: Codable, Equatable, Hashable {
    var id = UUID()
    
    @Guide(description: "A test topic name without \"Quiz\" word. No more than 2 words. Only theme or topic.")
    var name: String
    
    @Guide(description: "A short description of the test in 2-3 sentences. Explain what the test is about, which topics it covers, and how it can be useful for the participant.")
    var description: String
    
    var difficulty: Quiz.Difficulty
    var questions: [QuizQuestion]
    
    @Guide(description: "Duration of the test in seconds", .range(30...90))
    var timer: Int
    
    var currentQuestionIndex: Int = 0
    
    mutating internal func increaseQuestionIndex() {
        currentQuestionIndex += 1
    }
    
    var correctAnswers: Int = 0
    
    mutating internal func increaseCorrectAnswers() {
        correctAnswers += 1
    }
    
    enum CodingKeys: CodingKey {
        case name, description, difficulty
        case questions, timer
    }
    
    static internal var sampleData: Quiz {
        Quiz(name: "Sample Quiz",
             description: "A short description of the test in 2-3 sentences. Explain what the test is about, which topics it covers, and how it can be useful for the participant.",
             difficulty: .easy,
             questions: QuizQuestion.sampleData,
             timer: 70)
    }
}

