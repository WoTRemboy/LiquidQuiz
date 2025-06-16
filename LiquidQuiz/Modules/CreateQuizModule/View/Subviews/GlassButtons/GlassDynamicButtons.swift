//
//  GlassDynamicButtons.swift
//  LiquidQuiz
//
//  Created by Roman Tverdokhleb on 11/06/2025.
//

import SwiftUI

struct GlassDynamicButtons: View {
    
    @EnvironmentObject private var viewModel: CreateQuizViewModel
    
    private let namespace: Namespace.ID
    
    init(namespace: Namespace.ID) {
        self.namespace = namespace
    }
    
    internal var body: some View {
        HStack {
            if !viewModel.isQuizTopicEmpty {
                clearButtonView
            }
            randomButton
        }
    }
    
    private var clearButtonView: some View {
        Image.QuizGenerate.clear
            .font(.title2)
            .foregroundStyle(Color.red)
        
            .padding()
            .frame(width: 60, height: 60)
            .glassEffect(.regular.interactive())
            .glassEffectID(Texts.Namespace.QuizGenerate.clear, in: namespace)
        
            .onTapGesture {
                withAnimation {
                    viewModel.setQuizTopic()
                }
            }
    }
    
    private var randomButton: some View {
        Image.QuizGenerate.random
            .font(.title2)
            .padding()
            .frame(width: 60, height: 60)
        
            .glassEffect(.regular.interactive(), in: .circle)
            .glassEffectID(Texts.Namespace.QuizGenerate.random, in: namespace)
        
            .onTapGesture {
                withAnimation {
                    viewModel.setQuizTopic(random: true)
                }
                let impactMed = UIImpactFeedbackGenerator(style: .soft)
                impactMed.impactOccurred()
            }
    }
}

#Preview {
    GlassDynamicButtons(namespace: Namespace().wrappedValue)
        .environmentObject(CreateQuizViewModel())
}
