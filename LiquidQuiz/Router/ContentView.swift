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
            NavigationStack(path: bindingForTab(.create)) {
                CreateQuizView()
                    .environmentObject(appRouter)
                    .navigationDestination(for: AppRouter.Route.self) { route in
                        route.destinationView(in: .create, appRouter: appRouter)
                    }
            }
            .tag(AppRouter.Tab.create)
            
            NavigationStack(path: bindingForTab(.sets)) {
                Text("Sets Tab")
                    .environmentObject(appRouter)
                    .navigationDestination(for: AppRouter.Route.self) { route in
                        route.destinationView(in: .sets, appRouter: appRouter)
                    }
            }
            .tag(AppRouter.Tab.sets)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AppRouter())
        .environmentObject(CreateQuizViewModel())
}
