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
        
    var body: some View {
        ScrollView {
            if let quiz = generateManager?.quiz {
                VStack {
                    if let name = quiz.name {
                        Text(name)
                            .contentTransition(.opacity)
                    }
                    
                    if let dif = quiz.difficulty {
                        Text(dif.rawValue)
                            .contentTransition(.opacity)
                    }
                    if let timer = quiz.timer {
                        Text(String(timer))
                            .contentTransition(.opacity)
                    }
                    
                    if let questions = quiz.questions {
                        ForEach(questions) { quiestion in
                            if let format = quiestion.format {
                                Text(format)
                            }
                            
                            if let quest = quiestion.question {
                                Text(quest)
                            }
                            
                            if let price = quiestion.price {
                                Text(String(price))
                            }
                            if let options = quiestion.options {
                                ForEach(options, id: \.id) { option in
                                    if let name = option.name {
                                        Text(name)
                                    }
                                    
                                    if let correct = option.isCorrect {
                                        Text(String(correct))
                                    }
                                    
                                }
                            }
                            
                            if let explanation = quiestion.explanation {
                                Text(explanation)
                            }
                            if let hint = quiestion.hint {
                                Text(hint)
                            }
                            
                        }
                    }
                    
                }
                .animation(.easeInOut, value: quiz)
            }
            
        }
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
    
    func requestItinerary() async throws {
        requestedQuiz = true
        do {
            try await generateManager?.generateQuiz(for: "Towns", count: 10, difficulty: .hard)
        } catch {
            print(error.localizedDescription)
//            generateManager?.error = error
        }
    }
}

#Preview {
    QuizInfoView()
}
