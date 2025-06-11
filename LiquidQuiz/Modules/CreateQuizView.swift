//
//  CreateQuizView.swift
//  LiquidQuiz
//
//  Created by Roman Tverdokhleb on 11/06/2025.
//

import SwiftUI

struct CreateQuizView: View {
    
    @State private var quizTheme: String = String()
    @Namespace var namespace
    
    internal var body: some View {
        VStack(spacing: 50) {
            Text(Texts.QuizGenerate.title)
                .font(.largeTitle)
                .fontWeight(.semibold)
            
            themeContent
        }
    }
    
    private var themeContent: some View {
        VStack(spacing: 20) {
            TextField(Texts.QuizGenerate.textField,
                      text: $quizTheme.animation())
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 30)
            
            glassContent
        }
    }
    
    private var glassContent: some View {
        GlassEffectContainer {
            HStack {
                if !quizTheme.isEmpty {
                    clearButton
                }
                randomButton
                generateButton
            }
        }
    }
    
    private var clearButton: some View {
        Button {
            withAnimation {
                quizTheme = String()
            }
        } label: {
            Image.QuizGenerate.clear
                .foregroundStyle(Color.red)
                .font(.body)
        }
        .buttonStyle(.glass)
        .glassEffectID(Texts.Namespace.QuizGenerate.clear, in: namespace)
    }
    
    private var randomButton: some View {
        Button {
            // Random Button Action
        } label: {
            Text(Texts.QuizGenerate.random)
                .font(.body)
        }
        .buttonStyle(.glass)
        .glassEffectID(Texts.Namespace.QuizGenerate.random, in: namespace)
    }
    
    private var generateButton: some View {
        Button {
            // Generate Button Action
        } label: {
            Text(Texts.QuizGenerate.generate)
                .font(.body)
        }
        .buttonStyle(.glass)
    }
}

#Preview {
    CreateQuizView()
}
