//
//  CreateQuizControllersView.swift
//  LiquidQuiz
//
//  Created by Roman Tverdokhleb on 11/06/2025.
//

import SwiftUI

struct CreateQuizControllersView: View {
    
    @EnvironmentObject private var viewModel: CreateQuizViewModel
    
    internal var body: some View {
        VStack(spacing: 20) {
            textField
            
            if viewModel.isSliderExpanded {
                questionCountSlider
            }
            if viewModel.isDifficultyExpanded {
                difficultyPicker
            }
        }
    }
    
    private var textField: some View {
        TextField(Texts.QuizGenerate.textField,
                  text: $viewModel.quizTopic.animation())
        .padding()
        .glassEffect(.regular.interactive())
    }
    
    private var questionCountSlider: some View {
        Slider(value: $viewModel.questionCount.animation(),
               in: 1...30,
               step: 5) {
            Text(Texts.QuizGenerate.slider)
        } minimumValueLabel: {
            Text(viewModel.questionCountRange(for: .begin))
        } maximumValueLabel: {
            Text(viewModel.questionCountRange(for: .end))
        }
        .transition(.blurReplace)
    }
    
    private var difficultyPicker: some View {
        Picker(Texts.QuizGenerate.difficulty,
               selection: $viewModel.quizDifficulty.animation()) {
            menuFactory(cases: Quiz.Difficulty.allCases)
        }
               .pickerStyle(.segmented)
               .transition(.blurReplace)
    }
    
    @ViewBuilder
    internal func menuFactory(cases: [Quiz.Difficulty]) -> some View {
        ForEach(cases, id: \.self) { difficulty in
            Button {
                viewModel.setQuizDifficulty(to: difficulty)
            } label: {
                HStack {
                    difficulty.icon
                    Text(difficulty.rawValue)
                }
            }
        }
    }
}

#Preview {
    CreateQuizControllersView()
        .environmentObject(CreateQuizViewModel())
}
