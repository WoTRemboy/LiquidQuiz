//
//  ProfileTabDestinationFactory.swift
//  LiquidQuiz
//
//  Created by Roman Tverdokhleb on 25/12/2025.
//

import SwiftUI

struct ProfileTabDestinationFactory {
    @ViewBuilder
    static func view(for route: AppRouter.Route, appRouter: AppRouter) -> some View {
        switch route {
        case .profile:
            ProfileView()
            
        default:
            EmptyView()
        }
    }
}
