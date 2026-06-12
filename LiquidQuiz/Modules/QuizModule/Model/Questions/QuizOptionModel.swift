//
//  QuizOptionModel.swift
//  LiquidQuiz
//
//  Created by Roman Tverdokhleb on 13/06/2025.
//

import Foundation
import FoundationModels

@Generable
struct QuizOption: Codable, Equatable, Hashable {
    var id = UUID()
    
    @Guide(description: "Answer option text. It must be unique among the options for the same question.")
    var name: String
    
    @Guide(description: "Set to true only for the single correct answer. Set to false for every incorrect answer.")
    var isCorrect: Bool
    
    enum CodingKeys: CodingKey {
        case name
        case isCorrect
    }
}
