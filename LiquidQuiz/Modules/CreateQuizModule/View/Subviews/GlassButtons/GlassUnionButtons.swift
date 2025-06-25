//
//  GlassUnionButtons.swift
//  LiquidQuiz
//
//  Created by Roman Tverdokhleb on 11/06/2025.
//

import SwiftUI

struct GlassUnionButtons: View {
    
    @EnvironmentObject private var viewModel: CreateQuizViewModel
    
    private let namespace: Namespace.ID
    
    init(namespace: Namespace.ID) {
        self.namespace = namespace
    }
    
    internal var body: some View {
        HStack(spacing: 8) {
            questionsCountView
            difficultyButton
        }
    }
    
    private var questionsCountView: some View {
        Image.QuizGenerate.count
            .font(.title2)
            .contentTransition(.numericText(value: viewModel.questionCount))
        
            .padding()
            .frame(width: 60, height: 60)
            .glassEffect(.regular.interactive())
        
            .onTapGesture {
                withAnimation {
                    viewModel.isSliderExpandedToggle()
                }
            }
            .sensoryFeedback(.impact, trigger: viewModel.isSliderExpanded)
    }
    
//    @ViewBuilder
//    private var questionCountContent: some View {
//        if viewModel.isSliderExpanded {
//            Text(viewModel.questionCountLabel)
//        } else {
//            Image.QuizGenerate.count
//        }
//    }
    
    private var difficultyButton: some View {
        viewModel.quizDifficulty.icon
            .font(.title2)
            .padding()
            .frame(width: 60, height: 60)
            .glassEffect(.regular.interactive())
        
            .onTapGesture {
                withAnimation {
                    viewModel.isDifficultyExpandedToggle()
                }
            }
            .sensoryFeedback(.impact, trigger: viewModel.isDifficultyExpanded)
    }
}

#Preview {
    GlassUnionButtons(namespace: Namespace().wrappedValue)
        .environmentObject(CreateQuizViewModel())
}
