//
//  SettingsTabDestinationFactory.swift
//  LiquidQuiz
//
//  Created by Roman Tverdokhleb on 14/07/2025.
//

import SwiftUI

struct SettingsTabDestinationFactory {
    @ViewBuilder
    static func view(for route: AppRouter.Route, appRouter: AppRouter) -> some View {
        switch route {
        case .settings:
            Text("Settings Tab")
        default:
            EmptyView()
        }
    }
}
