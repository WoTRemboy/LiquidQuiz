//
//  CreateTabDestinationFactory.swift
//  LiquidQuiz
//
//  Created by Roman Tverdokhleb on 14/06/2025.
//

import SwiftUI

struct CreateTabDestinationFactory {
    @ViewBuilder
    static func view(for route: AppRouter.Route, appRouter: AppRouter) -> some View {
        switch route {
        case .create:
            CreateQuizView()
            
        case .quizInfo(let topic, let count, let difficulty):
            QuizInfoView(topic: topic, count: count, difficulty: difficulty)
                .environmentObject(appRouter)
            
        case .quizSelf(let quiz):
            QuizSelfView(quiz: quiz)
                .environmentObject(appRouter)
            
        case .quizResult(let viewModel):
            QuizSelfResultView(viewModel: viewModel)
                .environmentObject(appRouter)
        }
    }
}
