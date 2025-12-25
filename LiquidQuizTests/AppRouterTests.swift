//
//  AppRouterTests.swift
//  LiquidQuizTests
//
//  Created by Roman Tverdokhleb on 22/06/2025.
//

import Testing
@testable import LiquidQuiz

/// Test suite for the `AppRouter` class responsible for navigation and tab management.
@Suite("AppRouter Navigation and Tab Management")
struct AppRouterTests {

    /// Tests pushing a route onto a navigation stack and then popping it.
    @Test("Initial state is correct")
    func testInitialState() {
        let router = AppRouter()
        #expect(router.selectedTab == .roadmap, "Selected tab should default to .roadmap.")
        #expect(router.navigationPaths[.roadmap]?.isEmpty == true, "Navigation path for .roadmap should be empty initially.")
    }
    
    /// Tests pushing a route onto a navigation stack and then popping it.
    @Test("Push and pop routes")
    func testPushAndPop() {
        let router = AppRouter()
        router.push(.create, in: .create)
        #expect(router.navigationPaths[.create]?.count == 1, "Navigation stack should have one route after push.")
        
        router.pop(in: .create)
        #expect(router.navigationPaths[.create]?.isEmpty == true, "Navigation stack should be empty after pop.")
    }
    
    /// Tests the popToRoot functionality.
    @Test("Pop to root clears all routes in tab")
    func testPopToRoot() {
        let router = AppRouter()
        router.push(.create, in: .create)
        router.push(.create, in: .create)
        #expect(router.navigationPaths[.create]?.count == 2, "Navigation stack should have two routes after pushes.")
        router.popToRoot(in: .create)
        #expect(router.navigationPaths[.create]?.isEmpty == true, "Navigation stack should be empty after popToRoot.")
    }
}
