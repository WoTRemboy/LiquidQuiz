//
//  ImageExtension.swift
//  LiquidQuiz
//
//  Created by Roman Tverdokhleb on 11/06/2025.
//

import SwiftUI

extension Image {
    enum QuizGenerate {
        static let clear = Image(systemName: "eraser")
        static let random = Image(systemName: "dice")
        static let count = Image(systemName: "square.grid.2x2")
        static let difficulty = Image(systemName: "dial.medium")
        
        enum Difficulty {
            static let easy = Image(systemName: "dial.low")
            static let normal = Image(systemName: "dial.medium")
            static let hard = Image(systemName: "dial.high")
        }
    }
}
