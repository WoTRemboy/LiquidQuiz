//
//  QuizGenerationManager.swift
//  LiquidQuiz
//
//  Created by Roman Tverdokhleb on 15/06/2025.
//

import Observation
import FoundationModels

@Observable
@MainActor
final class QuizGenerationManager {
    private(set) var quiz: Quiz.PartiallyGenerated?
    private let session: LanguageModelSession
        
    init() {
        self.session = LanguageModelSession {
            "Your job is to create a comprehensive single-choice quiz on the given topic."
            
            """
            Each question should cover a different aspect of the topic.
            The quiz must contain exactly given questions.
            Present all questions and answer choices in the same language as the original topic or question (for full multilingual support).
            All answer choices for each question must be unique.
            Questions should gradually increase in difficulty with the easiest question based on the given level and progressing to more challenging ones. The value (price) of a question should be up to 50 at easy level, up to 70 at normal, and up to 100 at hard.
            If you need to insert a blank (for a missing word or any gap), display it as ____.
            """
        }
    }
    
    internal func generateQuiz(for name: String, count: Int, difficulty: Quiz.Difficulty) async throws {
        let stream = session.streamResponse(generating: Quiz.self) {
            """
            Generate a quiz where the topic is \(name). 
            - Include exactly \(count) questions.
            - Start diffculty is \(difficulty.rawValue).
            - Keep everything in the same language as the topic.
            """
        }
        for try await partialQuiz in stream {
            quiz = partialQuiz
        }
    }
    
}
