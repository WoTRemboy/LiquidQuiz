//
//  SetsTabDestinationFactory.swift
//  LiquidQuiz
//
//  Created by Roman Tverdokhleb on 13/07/2025.
//

import SwiftUI

struct SetsTabDestinationFactory {
    @ViewBuilder
    static func view(for route: AppRouter.Route, appRouter: AppRouter) -> some View {
        switch route {
        case .sets:
            Text("Sets Tab")
        default:
            EmptyView()
        }
    }
}
