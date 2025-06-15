//
//  QuizInfoView.swift
//  LiquidQuiz
//
//  Created by Roman Tverdokhleb on 15/06/2025.
//

import SwiftUI
import FoundationModels

struct QuizInfoView: View {
    @State private var isResponding: Bool = false
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
                segmentLabel
                ForEach(questions) { question in
                    LazyVStack {
                        QuizGenerateQuestionView(
                            question: question,
                            namespace: namespace)
                    }
                }
            }
            
            QuizGenerateProgressView(
                title: title,
                namespace: namespace,
                manager: $generateManager,
                isResponding: $isResponding)
            .padding(.top, 10)
        }
        .scrollBounceBehavior(.basedOnSize, axes: [.vertical])
        
        .navigationTitle(title)
        .toolbarTitleDisplayMode(.inlineLarge)
        .navigationBarBackButtonHidden()
        
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        
        .animation(.easeInOut, value: isResponding)
        .animation(.easeInOut, value: generateManager?.quiz)
        
        .safeAreaInset(edge: .bottom) {
            Button {
                Task {
                    try? await requestItinerary()
                }
            } label: {
                Text("Begin")
            }
            .disabled(isResponding)
        }
        .task {
            generateManager = QuizGenerationManager()
        }
    }
    
    private var segmentLabel: some View {
        Text(Texts.QuizGenerate.roadmap)
            .font(.title)
            .fontWeight(.bold)
        
            .padding([.horizontal])
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var title: String {
        if let quiz = generateManager?.quiz, let title = quiz.name {
            return title
        }
        return String()
    }
    
    private func requestItinerary() async throws {
        isResponding = true
        do {
            try await generateManager?.generateQuiz(for: topic, count: count, difficulty: difficulty)
            isResponding = false
        } catch {
            print(error.localizedDescription)
        }
    }
}

#Preview {
    QuizInfoView(topic: "Towns", count: 3, difficulty: .easy)
}
