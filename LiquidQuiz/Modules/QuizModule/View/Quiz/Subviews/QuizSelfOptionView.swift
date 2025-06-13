//
//  QuizSelfOptionView.swift
//  LiquidQuiz
//
//  Created by Roman Tverdokhleb on 13/06/2025.
//

import SwiftUI

struct QuizSelfOptionView: View {
    
    @StateObject private var viewModel: QuizViewModel
    @Namespace private var namespace: Namespace.ID
    
    private let question: QuizQuestion
    private let option: QuizOption
    
    init(question: QuizQuestion, option: QuizOption, viewModel: QuizViewModel) {
        self.question = question
        self.option = option
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    internal var body: some View {
        VStack(spacing: 5) {
            optionButton
            
            if viewModel.showExplanation(for: question, option: option) {
                explanationView
            }
        }
        .glassEffectUnion(id: Texts.Namespace.QuizSelf.container, namespace: namespace)
    }
    
    private var optionButton: some View {
        Text(option.name)
            .font(.title3)
            .padding()
            .frame(maxWidth: .infinity)
            .contentShape(.capsule)
        
            .glassEffect(.regular.interactive().tint(viewModel.optionColor(question: question, currentOption: option)))
            .glassEffectID(Texts.Namespace.QuizSelf.option, in: namespace)
            .animation(.spring(duration: 0.3), value: question.selectedAnswer)
        
            .onTapGesture {
                guard question.isSelectedAnswerEmpty else { return }
                withAnimation(.spring(duration: 0.3)) {
                    viewModel.setSelectedAnswer(answer: option)
                }
            }
            .sensoryFeedback(
                viewModel.sensoryFeedback(currentOption: option),
                trigger: question.selectedAnswer == option)
    }
    
    private var explanationView: some View {
        Text(viewModel.currentQuestion.explanation)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        
            .glassEffect(.regular.tint(.orange.opacity(0.3)))
            .glassEffectID(Texts.Namespace.QuizSelf.explanation, in: namespace)
    }
}

#Preview {
    let mock = Quiz.sampleData
    let question = mock.questions.first!
    let option = question.options.first!
    let viewModel = QuizViewModel(quiz: mock)
    
    QuizSelfOptionView(question: question, option: option, viewModel: viewModel)
}
