//
//  ContentView.swift
//  LiquidQuiz
//
//  Created by Roman Tverdokhleb on 14/06/2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var appRouter = AppRouter()
    @State private var search: String = String()
    
    private func bindingForTab(_ tab: AppRouter.Tab) -> Binding<[AppRouter.Route]> {
        Binding(
            get: { appRouter.navigationPaths[tab] ?? [] },
            set: { appRouter.navigationPaths[tab] = $0 }
        )
    }
    
    internal var body: some View {
        TabView(selection: $appRouter.selectedTab) {
            Tab(AppRouter.Tab.title(for: .create),
                systemImage: AppRouter.Tab.image(for: .create),
                value: .create) {
                NavigationStack(path: bindingForTab(.create)) {
                    CreateQuizView()
                        .environmentObject(appRouter)
                        .navigationDestination(for: AppRouter.Route.self) { route in
                            route.destinationView(in: .create, appRouter: appRouter)
                        }
                }
            }
            
            Tab(AppRouter.Tab.title(for: .sets),
                systemImage: AppRouter.Tab.image(for: .sets),
                value: .sets) {
                NavigationStack(path: bindingForTab(.sets)) {
                    Text("Sets Tab")
                        .environmentObject(appRouter)
                        .navigationDestination(for: AppRouter.Route.self) { route in
                            route.destinationView(in: .sets, appRouter: appRouter)
                        }
                }
            }
            
            Tab(AppRouter.Tab.title(for: .settings),
                systemImage: AppRouter.Tab.image(for: .settings),
                value: .settings) {
                NavigationStack(path: bindingForTab(.settings)) {
                    Text("Settings Tab")
                        .environmentObject(appRouter)
                        .navigationDestination(for: AppRouter.Route.self) { route in
                            route.destinationView(in: .settings, appRouter: appRouter)
                        }
                }
            }
            
            Tab(value: .search, role: .search) {
                NavigationStack {
                    List {
                        Text("Search Screen")
                    }
                    .navigationTitle("Search")
                    .searchable(text: $search)
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AppRouter())
        .environmentObject(CreateQuizViewModel())
}
