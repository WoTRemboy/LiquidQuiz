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
            
        case .quizInfo:
            QuizInfoView()
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
