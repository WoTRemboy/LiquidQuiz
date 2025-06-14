//
//  QuizSelfTimerScoreView.swift
//  LiquidQuiz
//
//  Created by Roman Tverdokhleb on 14/06/2025.
//

import SwiftUI

struct QuizSelfTimerScoreView: View {
    
    @StateObject private var viewModel: QuizViewModel
    @State private var isShowingTimer: Bool = false
    
    private let namespace: Namespace.ID
    
    init(namespace: Namespace.ID, viewModel: QuizViewModel) {
        self.namespace = namespace
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    internal var body: some View {
        timerScoreContainer
    }
    
    private var timerScoreContainer: some View {
        GlassEffectContainer {
            HStack {
                scoreLabel
                if isShowingTimer {
                    timerLabel
                        .offset(y: 30)
                }
            }
        }
    }
    
    private var timerLabel: some View {
        Text("10:00")
            .font(.title2)
            .padding()
            .glassEffect(.regular.interactive())
            .glassEffectID(Texts.Namespace.QuizResults.timer, in: namespace)
            .transition(.blurReplace)
    }
    
    private var scoreLabel: some View {
        Text("\(viewModel.quizScore)")
            .font(.system(size: 40))
            .fontWeight(.medium)
        
            .lineLimit(1)
            .minimumScaleFactor(0.7)
            .frame(maxWidth: .infinity)
        
            .padding()
            .glassEffect(.regular.interactive().tint(.green.opacity(0.2)))
            .glassEffectID(Texts.Namespace.QuizResults.score, in: namespace)
        
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation {
                        isShowingTimer.toggle()
                    }
                }
            }
    }
}

#Preview {
    let mock = Quiz.sampleData
    let viewModel = QuizViewModel(quiz: mock)
    
    QuizSelfTimerScoreView(namespace: Namespace().wrappedValue, viewModel: viewModel)
}
