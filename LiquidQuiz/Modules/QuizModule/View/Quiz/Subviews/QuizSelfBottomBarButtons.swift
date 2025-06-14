//
//  QuizSelfBottomBarButtons.swift
//  LiquidQuiz
//
//  Created by Roman Tverdokhleb on 13/06/2025.
//

import SwiftUI

struct QuizSelfBottomBarButtons: View {
    
    @StateObject private var viewModel: QuizViewModel
    @EnvironmentObject private var appRouter: AppRouter
        
    init(viewModel: QuizViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    internal var body: some View {
        GlassEffectContainer {
            VStack {
                controllers
            }
            .padding(.bottom)
        }
    }
    
    private var controllers: some View {
        HStack {
            closeButton
            timerView
            if viewModel.isLastQuestion {
                navigationButton
            } else {
                forwardButton
            }
        }
    }
    
    private var closeButton: some View {
        QuizSelfCloseButton(viewModel: viewModel) {
            appRouter.pop(in: .create)
        }
    }
    
    private var timerView: some View {
        Text("10:00")
            .font(.largeTitle)
            .fontWeight(.semibold)
        
            .padding(.horizontal)
            .frame(maxWidth: .infinity)
        
            .padding()
            .glassEffect(.regular.interactive())
    }
    
    private var navigationButton: some View {
        Button {
            appRouter.push(.quizResult(viewModel: viewModel), in: .create)
        } label: {
            forwardImage
        }
        .animation(.spring(duration: 0.3), value: viewModel.currentQuestion.selectedAnswer)
        .buttonStyle(.glass)
        .padding(.trailing)
    }
    
    private var forwardButton: some View {
        Button {
            withAnimation {
                viewModel.nextQuestion()
            }
        } label: {
            forwardImage
        }
        .animation(.spring(duration: 0.3), value: viewModel.currentQuestion.selectedAnswer)
        .buttonStyle(.glass)
        .padding(.trailing)
    }
    
    private var forwardImage: some View {
        Image.QuizSelf.forward
            .font(.title2)
            .fontWeight(.medium)
            .foregroundStyle(viewModel.nextQuestionColor)
            .padding()
    }
}

#Preview {
    let viewModel = QuizViewModel(quiz: Quiz.sampleData)
    return QuizSelfBottomBarButtons(viewModel: viewModel)
        .environmentObject(AppRouter())
}
