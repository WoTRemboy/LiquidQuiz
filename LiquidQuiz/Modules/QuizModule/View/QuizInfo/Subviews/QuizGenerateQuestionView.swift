//
//  QuizGenerateQuestionView.swift
//  LiquidQuiz
//
//  Created by Roman Tverdokhleb on 15/06/2025.
//

import SwiftUI

struct QuizGenerateQuestionView: View {
    
    private let question: QuizQuestion.PartiallyGenerated
    private let namespace: Namespace.ID
    
    init(question: QuizQuestion.PartiallyGenerated, namespace: Namespace.ID) {
        self.question = question
        self.namespace = namespace
    }
    
    internal var body: some View {
        GlassEffectContainer {
            HStack {
                titleFormatView
                if let price = question.price {
                    questionPrice(price: price)
                }
            }
            .glassEffectUnion(id: Texts.Namespace.QuizGenerate.titlePrice, namespace: namespace)
            .frame(height: 80)
        }
        
        .padding(.horizontal)
    }
    
    private var titleFormatView: some View {
        VStack(alignment: .leading) {
            if let format = question.format {
                Text(format)
                    .font(.headline)
            }
            
            if let title = question.title {
                Text(title)
                    .font(.body)
                    .lineLimit(1)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .glassEffect(.regular, in: .rect(cornerRadius: 10))
        .glassEffectID(Texts.Namespace.QuizGenerate.titleFormat, in: namespace)
    }
    
    @ViewBuilder
    private func questionPrice(price: Int) -> some View {
        VStack(alignment: .center, spacing: 0) {
            Text(String(price))
                .font(.title)
                .fontWeight(.medium)
            
            Text(Texts.QuizGenerate.price)
                .font(.caption)
        }
        .padding(.trailing)
        .transition(.blurReplace)
        .glassEffect(.regular)
        .glassEffectID(Texts.Namespace.QuizGenerate.questionPrice, in: namespace)
    }
}

//#Preview {
//    let mock = QuizQuestion.sampleData.first!
//    QuizGenerateQuestionView(question: mock, namespace: Namespace().wrappedValue)
//}
