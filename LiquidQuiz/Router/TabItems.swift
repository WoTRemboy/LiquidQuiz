//
//  TabItems.swift
//  LiquidQuiz
//
//  Created by Roman Tverdokhleb on 25/12/2025.
//

import SwiftUI

/// A utility struct providing configured tab items for the main tab bar.
struct TabItems {
    
    static func roadmapTab(appRouter: AppRouter) -> some View {
        RoadmapThemesView()
            .environmentObject(appRouter)
            .navigationDestination(for: AppRouter.Route.self) { route in
                route.destinationView(in: .roadmap, appRouter: appRouter)
            }
    }
    
    static func createTab(appRouter: AppRouter) -> some View {
        CreateQuizView()
            .environmentObject(appRouter)
            .navigationDestination(for: AppRouter.Route.self) { route in
                route.destinationView(in: .create, appRouter: appRouter)
            }
    }
    
    static func profileTab(appRouter: AppRouter) -> some View {
        ProfileView()
            .environmentObject(appRouter)
            .navigationDestination(for: AppRouter.Route.self) { route in
                route.destinationView(in: .profile, appRouter: appRouter)
            }
    }
    
    static func shopTab(appRouter: AppRouter) -> some View {
        ShopView()
            .environmentObject(appRouter)
            .navigationDestination(for: AppRouter.Route.self) { route in
                route.destinationView(in: .shop, appRouter: appRouter)
            }
    }
}

