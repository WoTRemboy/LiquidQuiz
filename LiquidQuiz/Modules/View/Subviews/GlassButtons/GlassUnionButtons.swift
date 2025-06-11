//
//  GlassUnionButtons.swift
//  LiquidQuiz
//
//  Created by Roman Tverdokhleb on 11/06/2025.
//

import SwiftUI

struct GlassUnionButtons: View {
    
    @EnvironmentObject private var viewModel: QuizViewModel
    
    private let namespace: Namespace.ID
    
    init(namespace: Namespace.ID) {
        self.namespace = namespace
    }
    
    internal var body: some View {
        HStack(spacing: 8) {
            questionsCountView
            difficultyButton
        }
        .glassEffectUnion(id: Texts.Namespace.QuizGenerate.container, namespace: namespace)
    }
    
    private var difficultyButton: some View {
        Image.QuizGenerate.difficulty
            .font(.title2)
            .padding()
            .glassEffect(.regular.interactive())
    }
    
    private var questionsCountView: some View {
        questionCountContent
            .font(.title2)
            .contentTransition(.numericText(value: viewModel.questionCount))
        
            .padding(.leading)
            .glassEffect(.regular.interactive())
            
            .onTapGesture {
                withAnimation {
                    viewModel.isSliderExpandedToggle()
                }
            }
    }
    
    @ViewBuilder
    private var questionCountContent: some View {
        if viewModel.isSliderExpanded {
            Text(viewModel.questionCountLabel)
        } else {
            Image.QuizGenerate.count
        }
    }
}

#Preview {
    GlassUnionButtons(namespace: Namespace().wrappedValue)
        .environmentObject(QuizViewModel())
}
