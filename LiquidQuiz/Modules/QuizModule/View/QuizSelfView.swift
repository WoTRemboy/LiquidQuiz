//
//  QuizSelfView.swift
//  LiquidQuiz
//
//  Created by Roman Tverdokhleb on 12/06/2025.
//

import SwiftUI

struct QuizSelfView: View {
    
    @StateObject private var viewModel: QuizViewModel
    @Environment(\.dismiss) private var dismiss
    @Namespace private var namespace
        
    let mock = QuizQuestion.sampleData.first!
    
    init(quiz: [QuizQuestion]) {
        let viewModel = QuizViewModel(quiz: quiz)
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    internal var body: some View {
        NavigationStack {
            scrollViewContent
                .safeAreaInset(edge: .top) {
                    progressBar
                        .padding(.vertical)
                }
                .safeAreaInset(edge: .bottom) {
                    QuizSelfBottomBarButtons(viewModel: viewModel) {
                        dismiss()
                    }
                }
                .toolbar {
                    ToolbarItem {
                        scoreView
                    }
                    ToolbarSpacer(.fixed)
                    
                    ToolbarItem {
                        hintButton
                    }
                }
                .navigationBarBackButtonHidden()
                .navigationTitle(Texts.QuizSelf.Toolbar.title)
                .toolbarTitleDisplayMode(.inline)
        }
    }
    
    private var progressBar: some View {
        ProgressBarView(current: 5, total: 10)
            .frame(height: 20)
            .padding(.horizontal)
    }
    
    private var scrollViewContent: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 40) {
                QuizSelfQuestionTitle(
                    format: mock.format,
                    question: mock.question)
                
                optionButtons
            }
            .padding(.horizontal)
        }
        .scrollBounceBehavior(.basedOnSize, axes: [.vertical])
    }
    
    private var optionButtons: some View {
        GlassEffectContainer {
            optionsView
        }
    }
    
    private var optionsView: some View {
        LazyVStack(spacing: 16) {
            ForEach(mock.options, id: \.self) { option in
                Text(option)
                    .font(.title3)
                    .padding()
                    .frame(maxWidth: .infinity)
                
                    .glassEffect(.regular.interactive().tint(viewModel.optionColor(current: option, correct: mock.answer)))
                
                    .onTapGesture {
                        guard viewModel.isSelectedAnswerEmpty else { return }
                        withAnimation(.spring(duration: 0.3)) {
                            viewModel.setSelectedAnswer(to: option)
                        }
                    }
            }
        }
    }
    
    private var scoreView: some View {
        Text("\(Texts.QuizSelf.Toolbar.score): \(viewModel.quizScore)")
            .contentTransition(.numericText(value: Double(viewModel.quizScore)))
            .padding(.horizontal)
            .frame(minWidth: 100, alignment: .center)
    }
    
    private var hintButton: some View {
        Button {
            viewModel.isShowingHintPopoverToggle()
        } label: {
            Image.QuizSelf.hint
        }
        .popover(isPresented: $viewModel.isShowingHintPopover) {
            Text(mock.hint)
                .padding()
                .presentationCompactAdaptation(.popover)
                .lineLimit(0)
        }
    }
    
    
}

#Preview {
    QuizSelfView(quiz: QuizQuestion.sampleData)
}
