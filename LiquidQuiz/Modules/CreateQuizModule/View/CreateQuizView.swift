//
//  CreateQuizView.swift
//  LiquidQuiz
//
//  Created by Roman Tverdokhleb on 11/06/2025.
//

import SwiftUI

struct CreateQuizView: View {
    
    @EnvironmentObject private var viewModel: CreateQuizViewModel
    @EnvironmentObject private var appRouter: AppRouter
    @Namespace private var namespace
    
    internal var body: some View {
        VStack(spacing: 50) {
            Text(Texts.QuizGenerate.title)
                .font(.largeTitle)
                .fontWeight(.semibold)
            
            topicContent
        }
        .frame(maxHeight: .infinity)
        
        .alert(viewModel.errorAlertContent.title, isPresented: $viewModel.isErrorAlertShown, actions: {
            Button(Texts.QuizGenerate.ModelStatusAlert.demo, role: .confirm) {
                appRouter.push(.quizSelf(quiz: Quiz.sampleData), in: .create)
            }
            Button(Texts.QuizGenerate.ModelStatusAlert.cancel, role: .cancel) {}
        }, message: {
            Text(viewModel.errorAlertContent.content)
        })
    }
    
    private var topicContent: some View {
        VStack(spacing: 20) {
            CreateQuizControllersView()
            GlassContainerButtons(namespace: namespace)
                .padding(.top)
            
            generateButton
                .padding(.vertical)
        }
        .padding(.horizontal, 30)
    }
    
    private var generateButton: some View {
        Button {
            viewModel.checkModelStatus {
                appRouter.push(.quizInfo(
                    topic: viewModel.quizTopic,
                    count: Int(viewModel.questionCount),
                    difficulty: viewModel.quizDifficulty),
                               in: .create)
            }
        } label: {
            Text(Texts.QuizGenerate.generate)
                .font(.title2)
                .frame(maxWidth: .infinity, maxHeight: 50)
        }
        .buttonStyle(.glass)
        .disabled(viewModel.isQuizTopicEmpty)
        .background(ShadowAnimatedGradient())
    }
}

#Preview {
    CreateQuizView()
        .environmentObject(CreateQuizViewModel())
        .environmentObject(AppRouter())
}
