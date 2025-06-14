//
//  CreateQuizView.swift
//  LiquidQuiz
//
//  Created by Roman Tverdokhleb on 11/06/2025.
//

import SwiftUI

struct CreateQuizView: View {
    
    @EnvironmentObject private var viewModel: QuizViewModel
    @EnvironmentObject private var appRouter: AppRouter
    @Namespace private var namespace
    
    internal var body: some View {
        VStack(spacing: 50) {
            Text(Texts.QuizGenerate.title)
                .font(.largeTitle)
                .fontWeight(.semibold)
            
            themeContent
        }
        .frame(maxHeight: .infinity)
        
        .safeAreaInset(edge: .bottom) {
            generateButton
                .padding(.horizontal, 30)
                .padding(.vertical)
        }
    }
    
    private var themeContent: some View {
        VStack(spacing: 20) {
            CreateQuizControllersView()
            GlassContainerButtons(namespace: namespace)
                .padding(.top)
        }
        .padding(.horizontal, 30)
    }
    
    private var generateButton: some View {
        Button {
            appRouter.push(.quizSelf(quiz: Quiz.sampleData), in: .create)
        } label: {
            Text(Texts.QuizGenerate.generate)
                .font(.title2)
                .frame(maxWidth: .infinity, maxHeight: 50)
        }
        .buttonStyle(.glass)
        .background(ShadowAnimatedGradient())
    }
}

#Preview {
    CreateQuizView()
        .environmentObject(CreateQuizViewModel())
        .environmentObject(AppRouter())
}
