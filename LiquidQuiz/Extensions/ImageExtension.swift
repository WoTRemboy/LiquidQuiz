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
        
        static let back = Image(systemName: "xmark")
        static let regenerate = Image(systemName: "arrow.clockwise")
        
        enum Difficulty {
            static let easy = Image(systemName: "dial.low")
            static let normal = Image(systemName: "dial.medium")
            static let hard = Image(systemName: "dial.high")
        }
        
        enum Progress {
            static let info = Image(systemName: "sparkle.magnifyingglass")
            static let questions = Image(systemName: "text.magnifyingglass")
        }
    }
    
    enum QuizSelf {
        static let hint = Image(systemName: "questionmark.circle")
        static let forward = Image(systemName: "arrow.forward")
        static let close = Image(systemName: "xmark")
    }
    
    enum Tabbar {
        static let create = Image(systemName: "plus.square")
        static let sets = Image(systemName: "square.stack.3d.up")
    }
}
