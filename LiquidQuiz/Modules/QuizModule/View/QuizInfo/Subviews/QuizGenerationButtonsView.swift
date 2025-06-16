//
//  QuizGenerationButtonsView.swift
//  LiquidQuiz
//
//  Created by Roman Tverdokhleb on 16/06/2025.
//

import SwiftUI

struct QuizGenerationButtonsView: View {
    
    @Binding private var isResponsing: Bool
    private let namespace: Namespace.ID
    
    private let forward: () -> Void
    private let regenerate: () -> Void
    private let dismiss: () -> Void
    
    init(namespace: Namespace.ID, isResponsing: Binding<Bool>, forward: @escaping () -> Void, regenerate: @escaping () -> Void, dismiss: @escaping () -> Void) {
        self.namespace = namespace
        self._isResponsing = isResponsing
        self.forward = forward
        self.regenerate = regenerate
        self.dismiss = dismiss
    }
    
    internal var body: some View {
        GlassEffectContainer {
            HStack {
                backButton
                
                if !isResponsing {
                    regenerateButton
                    beginButton
                }
            }
        }
        .animation(.easeInOut, value: isResponsing)
    }
    
    private var backButton: some View {
        Button {
            dismiss()
        } label: {
            Image.QuizGenerate.back
                .font(.title2)
                .fontWeight(.medium)
                .foregroundStyle(Color.red)
                .padding()
        }
        .buttonStyle(.glass)
        .glassEffectID(Texts.Namespace.QuizGenerate.backButton, in: namespace)
    }
    
    private var regenerateButton: some View {
        Button {
            regenerate()
        } label: {
            Image.QuizGenerate.regenerate
                .font(.title2)
                .fontWeight(.medium)
                .foregroundStyle(Color.orange)
                .padding()
        }
        .buttonStyle(.glass)
        .glassEffectID(Texts.Namespace.QuizGenerate.regenerateButton, in: namespace)
    }
    
    private var beginButton: some View {
        Button {
            forward()
        } label: {
            Text(Texts.QuizGenerate.begin)
                .font(.title2)
                .padding()
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(.glass)
        .glassEffectID(Texts.Namespace.QuizGenerate.beginButton, in: namespace)
    }
}

#Preview {
    QuizGenerationButtonsView(namespace: Namespace().wrappedValue, isResponsing: .constant(false)) {} regenerate: {} dismiss: {}
}
