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
    var name: String
    var isCorrect: Bool
    
    enum CodingKeys: CodingKey {
        case name
        case isCorrect
    }
}
