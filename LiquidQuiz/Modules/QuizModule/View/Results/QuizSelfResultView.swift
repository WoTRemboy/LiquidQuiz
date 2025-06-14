//
//  QuizSelfResultView.swift
//  LiquidQuiz
//
//  Created by Roman Tverdokhleb on 13/06/2025.
//

import SwiftUI

struct QuizSelfResultView: View {

    @StateObject private var viewModel: QuizViewModel
    
    @Environment(\.dismiss) private var dismiss
    @Namespace private var namespace
        
    init(viewModel: QuizViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    internal var body: some View {
        NavigationStack {
            VStack {
                percentScoreTimerView
                if viewModel.isShowingResultContent {
                    backButton
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            
            .padding(.horizontal)
            .toolbarVisibility(.hidden, for: .navigationBar)
        }
    }
    
    private var percentScoreTimerView: some View {
        VStack(spacing: 80) {
            QuizSelfResultPercentView(viewModel: viewModel)
            
            if viewModel.isShowingResultContent {
                QuizSelfTimerScoreView(namespace: namespace, viewModel: viewModel)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
    
    private var backButton: some View {
        Button {
            dismiss()
        } label: {
            Text(Texts.QuizResults.close)
                .font(.title2)
                .padding()
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(.glass)
        .padding(.bottom)
        .transition(.blurReplace)
    }
}

#Preview {
    let mock = Quiz.sampleData
    let viewModel = QuizViewModel(quiz: mock)
    
    QuizSelfResultView(viewModel: viewModel)
}
