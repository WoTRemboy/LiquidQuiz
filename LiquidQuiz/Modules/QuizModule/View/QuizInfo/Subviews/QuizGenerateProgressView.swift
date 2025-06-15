//
//  QuizGenerateProgressView.swift
//  LiquidQuiz
//
//  Created by Roman Tverdokhleb on 15/06/2025.
//

import SwiftUI

struct QuizGenerateProgressView: View {
    
    @State private var isExpanded: Bool = false
    
    private let title: String
    private let namespace: Namespace.ID
    
    init(title: String, namespace: Namespace.ID) {
        self.title = title
        self.namespace = namespace
    }
    
    internal var body: some View {
        renderProgressStack
    }
    
    private var renderProgressStack: some View {
        GlassEffectContainer {
            VStack {
                generateProgressView(type: .quizInfo)
                    .onAppear {
                        expandedToggle()
                    }
                if isExpanded {
                    generateProgressView(type: .questions)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal)
    }
    
    private func generateProgressView(type: QuizGeneration) -> some View {
        HStack {
            type.image
            Text("Generating \(title) \(type.rawValue)...")
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation(.snappy) {
                isExpanded.toggle()
            }
        }
    }
}

#Preview {
    QuizGenerateProgressView(title: "Towns", namespace: Namespace().wrappedValue)
}
