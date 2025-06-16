//
//  QuizGenerateInfoView.swift
//  LiquidQuiz
//
//  Created by Roman Tverdokhleb on 15/06/2025.
//

import SwiftUI
import FoundationModels

struct QuizGenerateInfoView: View {
    
    private let quiz: Quiz.PartiallyGenerated
    private let namespace: Namespace.ID
    
    init(quiz: Quiz.PartiallyGenerated, namespace: Namespace.ID) {
        self.quiz = quiz
        self.namespace = namespace
    }
    
    internal var body: some View {
        GlassEffectContainer {
            VStack(spacing: 20) {
                if let description = quiz.description {
                    descriptionLabel(content: description)
                }
                detailsStack
            }
        }
        .animation(.easeInOut, value: quiz)
        .padding(.horizontal)
    }
    
    @ViewBuilder
    private func sectionLabel(content: String) -> some View {
        Text(content)
            .font(.largeTitle)
            .fontWeight(.semibold)
        
            .contentTransition(.opacity)
            .transition(.blurReplace)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private func descriptionLabel(content: String) -> some View {
        Text(content)
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .glassEffect(.regular, in: .rect(cornerRadius: 10))
            .glassEffectID(Texts.Namespace.QuizGenerate.description, in: namespace)
        
            .contentTransition(.opacity)
            .transition(.blurReplace)
            
    }
    
    private var detailsStack: some View {
        HStack {
            if let count = quiz.questions?.count {
                countView(content: count)
            }
            if let difficulty = quiz.difficulty {
                difficultyView(content: difficulty)
            }
            if !timeString.isEmpty {
                timerView
            }
        }
    }
    
    @ViewBuilder
    private func countView(content: Int) -> some View {
        Text("\(content)")
            .font(.title)
            .contentTransition(.numericText(countsDown: false))
        
            .padding()
            .frame(width: 70, height: 70)
            .glassEffect(.regular.tint(.pink.opacity(0.1)), in: .circle)
            .glassEffectID(Texts.Namespace.QuizGenerate.count, in: namespace)
    }
    
    @ViewBuilder
    private func difficultyView(content: Quiz.Difficulty) -> some View {
        content.icon
            .font(.title)
            .contentTransition(.opacity)
        
            .padding()
            .frame(width: 70, height: 70)
        
            .glassEffect(.regular.tint(.orange.opacity(0.1)), in: .circle)
            .glassEffectID(Texts.Namespace.QuizGenerate.difficulty, in: namespace)
            
    }
    
    private var timerView: some View {
        Text("\(timeString)")
            .font(.title)
            .contentTransition(.opacity)
        
            .padding()
            .frame(height: 70)
            .glassEffect(.regular.tint(.blue.opacity(0.1)))
            .glassEffectID(Texts.Namespace.QuizGenerate.timer, in: namespace)
    }
    
    private var timeString: String {
        if let time = quiz.timer {
            let wasted = time
            let minutes = wasted / 60
            let seconds = wasted % 60
            return String(format: "%02d:%02d", minutes, seconds)
        }
        return String()
    }
}

//#Preview {
//    QuizGenerateInfoView(quiz: Quiz.sampleData, namespace: Namespace().wrappedValue)
//        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
//}
