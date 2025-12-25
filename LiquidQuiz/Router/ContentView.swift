//
//  ContentView.swift
//  LiquidQuiz
//
//  Created by Roman Tverdokhleb on 14/06/2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var appRouter = AppRouter()
    
    private func bindingForTab(_ tab: AppRouter.Tab) -> Binding<[AppRouter.Route]> {
        Binding(
            get: { appRouter.navigationPaths[tab] ?? [] },
            set: { appRouter.navigationPaths[tab] = $0 }
        )
    }
    
    internal var body: some View {
        TabView(selection: $appRouter.selectedTab) {
            Tab(AppRouter.Tab.roadmap.title,
                systemImage: AppRouter.Tab.roadmap.systemName,
                value: .roadmap) {
                NavigationStack(path: bindingForTab(.roadmap)) {
                    TabItems.roadmapTab(appRouter: appRouter)
                }
            }
            
            Tab(AppRouter.Tab.create.title,
                systemImage: AppRouter.Tab.create.systemName,
                value: .create) {
                NavigationStack(path: bindingForTab(.create)) {
                    TabItems.createTab(appRouter: appRouter)
                }
            }
            
            Tab(AppRouter.Tab.profile.title,
                systemImage: AppRouter.Tab.profile.systemName,
                value: .profile) {
                NavigationStack(path: bindingForTab(.profile)) {
                    TabItems.profileTab(appRouter: appRouter)
                }
            }
            
            Tab(AppRouter.Tab.shop.title,
                systemImage: AppRouter.Tab.shop.systemName,
                value: .shop,
                role: .search) {
                NavigationStack(path: bindingForTab(.shop)) {
                    TabItems.shopTab(appRouter: appRouter)
                }
            }
        }
        .accentColor(Color.SupportColors.orange)
    }
}

#Preview {
    ContentView()
        .environmentObject(AppRouter())
        .environmentObject(CreateQuizViewModel())
}
