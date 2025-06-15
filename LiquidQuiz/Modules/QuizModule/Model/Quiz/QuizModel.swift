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
    
    @Guide(description: "A specific test topic in 1-2 words.")
    var name: String
    
    var difficulty: Quiz.Difficulty
    var questions: [QuizQuestion]
    
    @Guide(description: "Duration of the test in seconds", .range(15...900))
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
        case name, difficulty
        case questions, timer
    }
    
//    static func == (lhs: Quiz, rhs: Quiz) -> Bool {
//        lhs.id == rhs.id
//    }
    
    static internal var sampleData: Quiz {
        Quiz(name: "Sample Quiz",
             difficulty: .easy,
             questions: QuizQuestion.sampleData,
             timer: 70)
    }
}
