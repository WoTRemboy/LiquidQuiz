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
        .onAppear {
            viewModel.startQuizTimer()
        }
        .onDisappear {
            viewModel.stopQuizTimer()
        }
        .onChange(of: viewModel.isTimerFinished) { _, isFinished in
            guard isFinished else { return }
            appRouter.push(.quizResult(viewModel: viewModel), in: .create)
        }
    }
    
    private var controllers: some View {
        HStack {
            closeButton
            timerView
            forwardButton
        }
    }
    
    private var closeButton: some View {
        QuizSelfCloseButton(viewModel: viewModel) {
            appRouter.pop(in: .create)
        }
    }
    
    private var timerView: some View {
        Text(viewModel.timeString)
            .font(.largeTitle)
            .fontWeight(.semibold)
        
            .animation(.default, value: viewModel.remainingTime)
            .contentTransition(.numericText(countsDown: true))
        
            .padding(.horizontal)
            .frame(maxWidth: .infinity)
        
            .padding()
            .glassEffect(.regular.interactive())
    }
    
    private var forwardButton: some View {
        Button {
            withAnimation {
                viewModel.nextQuestion() {
                    appRouter.push(.quizResult(viewModel: viewModel), in: .create)
                }
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
