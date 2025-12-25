//
//  RoadmapTabDestinationFactory.swift
//  LiquidQuiz
//
//  Created by Roman Tverdokhleb on 25/12/2025.
//

import SwiftUI

struct RoadmapTabDestinationFactory {
    @ViewBuilder
    static func view(for route: AppRouter.Route, appRouter: AppRouter) -> some View {
        switch route {
        case .roadmap:
            RoadmapThemesView()
            
        case .quizInfo(let topic, let count, let difficulty):
            QuizInfoView(topic: topic, count: count, difficulty: difficulty)
                .environmentObject(appRouter)
            
        case .quizSelf(let quiz):
            QuizSelfView(quiz: quiz)
                .environmentObject(appRouter)
            
        case .quizResult(let viewModel):
            QuizSelfResultView(viewModel: viewModel)
                .environmentObject(appRouter)
            
        default:
            EmptyView()
        }
    }
}
