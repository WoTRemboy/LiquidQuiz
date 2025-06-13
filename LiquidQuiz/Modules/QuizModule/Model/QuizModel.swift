//
//  QuizModel.swift
//  LiquidQuiz
//
//  Created by Roman Tverdokhleb on 12/06/2025.
//

import Foundation

struct Quiz: Codable {
    var id = UUID()
    var name: String
    var difficulty: QuizDifficulty
    var questions: [QuizQuestion]
    var timer: Int
    
    enum CodingKeys: CodingKey {
        case name, difficulty
        case questions, timer
    }
    
    static internal var sampleData: Quiz {
        Quiz(name: "Sample Quiz",
             difficulty: .easy,
             questions: QuizQuestion.sampleData,
             timer: 300)
    }
}
