//
//  AppRouter.swift
//  LiquidQuiz
//
//  Created by Roman Tverdokhleb on 14/06/2025.
//

import SwiftUI
import Combine

final class AppRouter: ObservableObject {
    
    @Published internal var selectedTab: Tab = .roadmap
    @Published internal var navigationPaths: [Tab: [Route]] = Tab.allCases.reduce(into: [:]) { $0[$1] = [] }
    
    enum Tab: CaseIterable, Hashable {
        case roadmap
        case create
        case profile
        case shop
        
        internal var title: String {
            switch self {
            case .roadmap: Texts.Tabbar.roadmap
            case .create: Texts.Tabbar.create
            case .profile: Texts.Tabbar.profile
            case .shop: Texts.Tabbar.shop
            }
        }
        
        internal var icon: Image {
            switch self {
            case .roadmap: Image.Tabbar.roadmap
            case .create: Image.Tabbar.create
            case .profile: Image.Tabbar.profile
            case .shop: Image.Tabbar.shop
            }
        }
        
        internal var systemName: String {
            switch self {
            case .roadmap: "point.bottomleft.filled.forward.to.point.topright.scurvepath"
            case .create: "sparkles"
            case .profile: "person"
            case .shop: "cart"
            }
        }
    }
    
    enum Route: Hashable {
        case roadmap
        case create
        case profile
        case shop
        
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
