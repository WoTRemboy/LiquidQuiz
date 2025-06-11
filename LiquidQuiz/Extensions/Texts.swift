//
//  Texts.swift
//  LiquidQuiz
//
//  Created by Roman Tverdokhleb on 11/06/2025.
//

import Foundation

struct Texts {
    enum QuizGenerate {
        static let title = "Generate"
        static let textField = "ex. Countries"
        static let random = "Suggest"
        static let generate = "Create"
        static let slider = "Questions Count"
    }
    
    enum Namespace {
        enum QuizGenerate {
            static let clear = "QuizGenerateClear"
            static let random = "QuizGenerateRandom"
            static let generate = "QuizGenerateGenerate"
            static let container = "QuizGenerateContainer"
        }
    }
}
