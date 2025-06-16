//
//  QuizGenerateProgressView.swift
//  LiquidQuiz
//
//  Created by Roman Tverdokhleb on 15/06/2025.
//

import SwiftUI

struct QuizGenerateProgressView: View {
    
    @State private var isExpanded: Bool = false
    @Binding private var isResponding: Bool
    @Binding private var manager: QuizGenerationManager?
    
    private let title: String
    private let namespace: Namespace.ID
    
    init(title: String, namespace: Namespace.ID, manager: Binding<QuizGenerationManager?>, isResponding: Binding<Bool>) {
        self.title = title
        self.namespace = namespace
        self._manager = manager
        self._isResponding = isResponding
    }
    
    internal var body: some View {
        GlassEffectContainer {
            VStack {
                if manager?.quiz?.difficulty == nil {
                    generateProgressView(type: .quizInfo)
                        .onAppear {
                            expandedToggle()
                        }
                }
                if isExpanded, isResponding {
                    generateProgressView(type: .questions)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal)
    }
    
    @ViewBuilder
    private func generateProgressView(type: QuizGeneration) -> some View {
        HStack {
            type.image
            Text("\(Texts.QuizGenerate.generating) \(titleContent) \(type.rawValue)...")
        }
        .font(.body)
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        
        .glassEffect()
        .glassEffectID(type.rawValue, in: namespace)
        
        .symbolEffect(.breathe, isActive: true)
        .background(ShadowAnimatedGradient())
    }
    
    private func expandedToggle() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            withAnimation(.snappy) {
                isExpanded.toggle()
            }
        }
    }
    
    private var titleContent: String {
        title.isEmpty ? Texts.QuizGenerate.title : title
    }
}

#Preview {
    QuizGenerateProgressView(
        title: "Towns",
        namespace: Namespace().wrappedValue,
        manager: .constant(QuizGenerationManager()),
        isResponding: .constant(true)
    )
}
