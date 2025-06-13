//
//  QuizSelfBottomBarButtons.swift
//  LiquidQuiz
//
//  Created by Roman Tverdokhleb on 13/06/2025.
//

import SwiftUI

struct QuizSelfBottomBarButtons: View {
    
    @StateObject private var viewModel: QuizViewModel
    
    private let dismiss: () -> Void
    
    init(viewModel: QuizViewModel, dismiss: @escaping () -> Void) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.dismiss = dismiss
    }
    
    internal var body: some View {
        GlassEffectContainer {
            VStack {
                controllers
            }
            .padding(.bottom)
        }
    }
    
    private var controllers: some View {
        HStack {
            closeButton
            timerView
            forwardButton
        }
    }
    
    private var closeButton: some View {
        Button {
            withAnimation {
                viewModel.isShowingResetDialogToggle()
            }
        } label: {
            Image.QuizSelf.close
                .font(.title2)
                .fontWeight(.medium)
                .foregroundStyle(Color.red)
                .padding()
        }
        .padding(.leading)
        .buttonStyle(.glass)
        
        .confirmationDialog(
            Texts.QuizSelf.ConfirmDialog.title,
            isPresented: $viewModel.isShowingResetDialog.animation(),
            titleVisibility: .visible
        ) {
            Button(role: .destructive) {
                dismiss()
            } label: {
                Text(Texts.QuizSelf.ConfirmDialog.confirm)
            }
        } message: {
            Text(Texts.QuizSelf.ConfirmDialog.message)
        }
    }
    
    private var timerView: some View {
        Text("10:00")
            .font(.largeTitle)
            .fontWeight(.semibold)
        
            .padding(.horizontal)
            .frame(maxWidth: .infinity)
        
            .padding()
            .glassEffect(.regular.interactive())
    }
    
    private var forwardButton: some View {
        Button {
            // Forward Button Action
        } label: {
            Image.QuizSelf.forward
                .font(.title2)
                .fontWeight(.medium)
                .foregroundStyle(Color.green)
                .padding()
        }
        .buttonStyle(.glass)
        .padding(.trailing)
    }
}

#Preview {
    let viewModel = QuizViewModel(quiz: Quiz.sampleData)
    return QuizSelfBottomBarButtons(viewModel: viewModel) {}
}
