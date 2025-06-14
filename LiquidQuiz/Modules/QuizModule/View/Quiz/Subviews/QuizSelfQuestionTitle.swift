//
//  QuizSelfQuestionTitle.swift
//  LiquidQuiz
//
//  Created by Roman Tverdokhleb on 13/06/2025.
//

import SwiftUI

struct QuizSelfQuestionTitle: View {
    
    private let format: String
    private let question: String
    
    init(format: String, question: String) {
        self.format = format
        self.question = question
    }
    
    internal var body: some View {
        VStack(spacing: 16) {
            formatLabel
            questionLabel
        }
    }
    
    private var formatLabel: some View {
        Text(format)
            .font(.title)
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var questionLabel: some View {
        Text(question)
            .font(.title2)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    let mock = QuizQuestion.sampleData.first!
    QuizSelfQuestionTitle(format: mock.format, question: mock.question)
}
