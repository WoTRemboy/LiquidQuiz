//
//  DestinationFactory.swift
//  LiquidQuiz
//
//  Created by Roman Tverdokhleb on 14/06/2025.
//

import SwiftUI

extension AppRouter.Route {
    @ViewBuilder
    internal func destinationView(in tab: AppRouter.Tab, appRouter: AppRouter) -> some View {
        switch tab {
        case .create:
            CreateTabDestinationFactory.view(for: self, appRouter: appRouter)
        case .sets:
            SetsTabDestinationFactory.view(for: self, appRouter: appRouter)
        case .search:
            EmptyView()
        }
    }
}
