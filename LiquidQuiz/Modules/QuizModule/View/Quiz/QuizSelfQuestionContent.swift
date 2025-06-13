//
//  QuizSelfQuestionContent.swift
//  LiquidQuiz
//
//  Created by Roman Tverdokhleb on 13/06/2025.
//

import SwiftUI

struct QuizSelfQuestionContent: View {
    
    @StateObject private var viewModel: QuizViewModel
    private let question: QuizQuestion
    
    init(question: QuizQuestion, viewModel: QuizViewModel) {
        self.question = question
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    internal var body: some View {
        VStack(spacing: 40) {
            QuizSelfQuestionTitle(
                format: question.format,
                question: question.question)
            
            optionButtons
        }
    }
    
    private var optionButtons: some View {
        GlassEffectContainer {
            optionsView
        }
    }
    
    private var optionsView: some View {
        LazyVStack(spacing: 16) {
            ForEach(question.options, id: \.id) { option in
                QuizSelfOptionView(question: question, option: option, viewModel: viewModel)
            }
        }
    }
}

#Preview {
    let mock = Quiz.sampleData
    let viewModel = QuizViewModel(quiz: mock)
    let question = mock.questions.first!
    
    QuizSelfQuestionContent(question: question, viewModel: viewModel)
}
