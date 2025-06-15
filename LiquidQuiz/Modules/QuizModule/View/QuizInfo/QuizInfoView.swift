//
//  QuizInfoView.swift
//  LiquidQuiz
//
//  Created by Roman Tverdokhleb on 15/06/2025.
//

import SwiftUI
import FoundationModels

struct QuizInfoView: View {
    @State private var requestedQuiz: Bool = false
    @State private var generateManager: QuizGenerationManager?
    
    @Namespace private var namespace
    
    private let topic: String
    private let count: Int
    private let difficulty: Quiz.Difficulty
    
    init(topic: String, count: Int, difficulty: Quiz.Difficulty) {
        self.topic = topic
        self.count = count
        self.difficulty = difficulty
    }
        
    internal var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            if let quiz = generateManager?.quiz {
                QuizGenerateInfoView(quiz: quiz, namespace: namespace)
            }
            
            if let questions = generateManager?.quiz?.questions {
                
            } else {
                QuizGenerateProgressView(title: title, namespace: namespace, manager: $generateManager)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationBarBackButtonHidden()
        .animation(.easeInOut, value: requestedQuiz)
        .animation(.easeInOut, value: generateManager?.quiz)
        
        .scrollBounceBehavior(.basedOnSize, axes: [.vertical])
        .safeAreaInset(edge: .bottom) {
            Button {
                Task {
                    try? await requestItinerary()
                }
            } label: {
                Text("Begin")
            }
            .disabled(requestedQuiz)
        }
        .task {
            generateManager = QuizGenerationManager()
        }
    }
    
    private var title: String {
        if let quiz = generateManager?.quiz, let title = quiz.name {
            return title
        }
        return topic
    }
    
    func requestItinerary() async throws {
        requestedQuiz = true
        do {
            try await generateManager?.generateQuiz(for: topic, count: count, difficulty: difficulty)
        } catch {
            print(error.localizedDescription)
//            generateManager?.error = error
        }
    }
}

#Preview {
    QuizInfoView(topic: "Towns", count: 3, difficulty: .easy)
}
