//
//  QuizDifficultyModel.swift
//  LiquidQuiz
//
//  Created by Roman Tverdokhleb on 11/06/2025.
//

import SwiftUI
import FoundationModels

extension Quiz {
    
    @Generable
    enum Difficulty: String, CaseIterable, Codable {
        case easy = "Easy"
        case normal = "Normal"
        case hard = "Hard"
        
        internal var icon: Image {
            switch self {
            case .easy:
                Image.QuizGenerate.Difficulty.easy
            case .normal:
                Image.QuizGenerate.Difficulty.normal
            case .hard:
                Image.QuizGenerate.Difficulty.hard
            }
        }
    }
}
