//
//  QuizSelfCloseButton.swift
//  LiquidQuiz
//
//  Created by Roman Tverdokhleb on 14/06/2025.
//

import SwiftUI

struct QuizSelfCloseButton: View {
    
    @StateObject private var viewModel: QuizViewModel
    
    private let dismiss: () -> Void
    
    init(viewModel: QuizViewModel, dismiss: @escaping () -> Void) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.dismiss = dismiss
    }
    
    internal var body: some View {
        Button {
            withAnimation {
                viewModel.isShowingResetDialogToggle()
            }
        } label: {
            buttonContent
        }
        .padding(.leading)
        .buttonStyle(.glass)
        
        .confirmationDialog(
            Texts.QuizSelf.ConfirmDialog.title,
            isPresented: $viewModel.isShowingResetDialog.animation(),
            titleVisibility: .visible
        ) {
            dismissButton
        } message: {
            Text(Texts.QuizSelf.ConfirmDialog.message)
        }
    }
    
    private var buttonContent: some View {
        Image.QuizSelf.close
            .font(.title2)
            .fontWeight(.medium)
            .foregroundStyle(Color.red)
            .padding()
    }
    
    private var dismissButton: some View {
        Button(role: .destructive) {
            dismiss()
        } label: {
            Text(Texts.QuizSelf.ConfirmDialog.confirm)
        }
    }
}

#Preview {
    let mock = Quiz.sampleData
    let viewModel = QuizViewModel(quiz: mock)
    
    QuizSelfCloseButton(viewModel: viewModel) {}
}
