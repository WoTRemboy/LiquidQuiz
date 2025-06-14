//
//  QuizSelfResultPercentView.swift
//  LiquidQuiz
//
//  Created by Roman Tverdokhleb on 14/06/2025.
//

import SwiftUI

struct QuizSelfResultPercentView: View {
    
    @StateObject private var viewModel: QuizViewModel
    
    init(viewModel: QuizViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        percentLabel
    }
    
    private var percentLabel: some View {
        Text("\(viewModel.correctAnswersPercent)\(viewModel.isShowingResultContent ? "%" : "")")
            .font(.system(size: 150))
            .fontWeight(.heavy)
        
            .minimumScaleFactor(0.7)
            .lineLimit(1)
            .frame(maxWidth: .infinity)
        
            .foregroundStyle(.secondary.opacity(0.5))
            .contentTransition(.numericText(value: Double(viewModel.correctAnswersPercent)))
        
            .onAppear {
                viewModel.scoreIncreasing()
            }
            .onDisappear {
                viewModel.percentCounterTimer?.invalidate()
                viewModel.percentCounterTimer = nil
            }
    }
}

#Preview {
    let mock = Quiz.sampleData
    let viewModel = QuizViewModel(quiz: mock)
    
    QuizSelfResultPercentView(viewModel: viewModel)
}
