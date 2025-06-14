//
//  QuizModel.swift
//  LiquidQuiz
//
//  Created by Roman Tverdokhleb on 12/06/2025.
//

import Foundation

struct Quiz: Codable, Equatable, Hashable {
    var id = UUID()
    var name: String
    var difficulty: QuizDifficulty
    var questions: [QuizQuestion]
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
    
    static func == (lhs: Quiz, rhs: Quiz) -> Bool {
        lhs.id == rhs.id
    }
    
    static internal var sampleData: Quiz {
        Quiz(name: "Sample Quiz",
             difficulty: .easy,
             questions: QuizQuestion.sampleData,
             timer: 300)
    }
}
