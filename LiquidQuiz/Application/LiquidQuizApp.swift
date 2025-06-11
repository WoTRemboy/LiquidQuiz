//
//  LiquidQuizApp.swift
//  LiquidQuiz
//
//  Created by Roman Tverdokhleb on 11/06/2025.
//

import SwiftUI

@main
struct LiquidQuizApp: App {
    var body: some Scene {
        WindowGroup {
            CreateQuizView()
                .environmentObject(QuizViewModel())
        }
    }
}
