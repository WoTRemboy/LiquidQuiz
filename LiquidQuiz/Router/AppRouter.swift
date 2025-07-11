//
//  AppRouter.swift
//  LiquidQuiz
//
//  Created by Roman Tverdokhleb on 14/06/2025.
//

import SwiftUI
import Combine

final class AppRouter: ObservableObject {
    
    @Published internal var selectedTab: Tab = .create
    @Published internal var navigationPaths: [Tab: [Route]] = Tab.allCases.reduce(into: [:]) { $0[$1] = [] }
    
    enum Tab: CaseIterable, Hashable {
        case create
        case sets
        
        internal var icon: Image {
            switch self {
            case .create:
                Image.Tabbar.create
            case .sets:
                Image.Tabbar.sets
            }
        }
        
        internal var title: String {
            switch self {
            case .create:
                Texts.Tabbar.create
            case .sets:
                Texts.Tabbar.sets
            }
        }
    }
    
    enum Route: Hashable {
        case create
        case quizInfo(topic: String, count: Int, difficulty: Quiz.Difficulty)
        case quizSelf(quiz: Quiz)
        case quizResult(viewModel: QuizViewModel)
    }
    
    internal func push(_ route: Route, in tab: Tab) {
        navigationPaths[tab, default: []].append(route)
    }
    
    internal func pop(in tab: Tab) {
        _ = navigationPaths[tab]?.popLast()
    }
    
    internal func popToRoot(in tab: Tab) {
        navigationPaths[tab] = []
    }
    
    internal func setTab(to tab: Tab) {
        if selectedTab == tab {
            popToRoot(in: tab)
        } else {
            selectedTab = tab
        }
    }
}
