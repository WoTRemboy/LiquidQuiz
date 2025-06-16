//
//  QuizGenerationModel.swift
//  LiquidQuiz
//
//  Created by Roman Tverdokhleb on 15/06/2025.
//

import SwiftUI

enum QuizGeneration: String {
    case quizInfo = "info"
    case questions = "questions"
    
    internal var image: Image {
        switch self {
        case .quizInfo:
            Image.QuizGenerate.Progress.info
        case .questions:
            Image.QuizGenerate.Progress.questions
        }
    }
}
