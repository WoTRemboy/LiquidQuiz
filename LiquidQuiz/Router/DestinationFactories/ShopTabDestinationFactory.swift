//
//  ShopTabDestinationFactory.swift
//  LiquidQuiz
//
//  Created by Roman Tverdokhleb on 25/12/2025.
//

import SwiftUI

struct ShopTabDestinationFactory {
    @ViewBuilder
    static func view(for route: AppRouter.Route, appRouter: AppRouter) -> some View {
        switch route {
        case .shop:
            ShopView()
            
        default:
            EmptyView()
        }
    }
}
