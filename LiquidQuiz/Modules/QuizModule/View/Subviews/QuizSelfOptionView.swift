//
//  QuizSelfOptionView.swift
//  LiquidQuiz
//
//  Created by Roman Tverdokhleb on 13/06/2025.
//

import SwiftUI

struct QuizSelfOptionView: View {
    
    @StateObject private var viewModel: QuizViewModel
    
    private let option: QuizOption
    
    init(option: QuizOption, viewModel: QuizViewModel) {
        self.option = option
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    internal var body: some View {
        Text(option.name)
            .font(.title3)
            .padding()
            .frame(maxWidth: .infinity)
        
            .glassEffect(.regular.interactive().tint(viewModel.optionColor(currentOption: option)))
        
            .onTapGesture {
                guard viewModel.isSelectedAnswerEmpty else { return }
                withAnimation(.spring(duration: 0.3)) {
                    viewModel.setSelectedAnswer(to: option)
                }
            }
    }
}

#Preview {
    let option = QuizOption(name: "tell you a story", isCorrect: true)
    let viewModel = QuizViewModel(quiz: Quiz.sampleData)
    
    return QuizSelfOptionView(option: option, viewModel: viewModel)
}
