//
//  CreateQuizView.swift
//  LiquidQuiz
//
//  Created by Roman Tverdokhleb on 11/06/2025.
//

import SwiftUI

struct CreateQuizView: View {
    
    @State private var quizTheme: String = String()
    @State private var questionCount: Double = 10.0
    private let questionCountRange: (from: Float, to: Float) = (1.0, 30.0)
    
    @Namespace private var namespace
    
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
            
            quiestionCountSlider
            glassContent
                .padding(.top, 20)
            generateButton
        }
        .padding(.horizontal, 30)
    }
    
    private var quiestionCountSlider: some View {
        Slider(value: $questionCount.animation(),
               in: 1...30,
               step: 5) {
            Text(Texts.QuizGenerate.slider)
        } minimumValueLabel: {
            Text("\(questionCountRange.from.formatted(.number))")
        } maximumValueLabel: {
            Text("\(questionCountRange.to.formatted(.number))")
        }
    }
    
    private var glassContent: some View {
        GlassEffectContainer {
            HStack {
                questionsCountView
                Spacer()
                HStack {
                    if !quizTheme.isEmpty {
                        clearButton
                    }
                    randomButton
                }
            }
        }
    }
    
    private var questionsCountView: some View {
        Text("\(questionCount.formatted(.number.rounded(rule: .down, increment: 1.0)))")
            .contentTransition(.numericText(value: questionCount))
        
            .padding(10)
            .glassEffect(.regular.interactive(), in: .circle)
        
            .onTapGesture {
                withAnimation {
                    questionCount = 10
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
