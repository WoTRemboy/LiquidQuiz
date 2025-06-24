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
    private var session: LanguageModelSession
    
    init() {
        self.session = QuizGenerationManager.sessionSetup()
    }
    
    internal func generateQuiz(for name: String, count: Int, difficulty: Quiz.Difficulty) async throws {
        session = QuizGenerationManager.sessionSetup()
        let stream = session.streamResponse(generating: Quiz.self) {
            """
            Generate a quiz where the topic is \(name). 
            - Include exactly \(count) questions. Not less, not more.
            - Start diffculty is \(difficulty.rawValue).
            - Keep everything in the same language as the topic.
            """
        }
        for try await partialQuiz in stream {
            quiz = partialQuiz
        }
    }
    
    static private func sessionSetup() -> LanguageModelSession {
        LanguageModelSession {
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
    
//    private func newSessionSetup(previousSession: LanguageModelSession) -> LanguageModelSession {
//        let allEntries = previousSession.transcript
//        var condensedEntries = [Transcript.Entry]()
//        if let firstEntry = allEntries.first {
//            condensedEntries.append(firstEntry)
//        }
//        
//        let condensedTranscript = Transcript(entries: condensedEntries)
//        return LanguageModelSession(transcript: condensedTranscript)
//    }
    
    internal func convertQuiz() -> Quiz? {
        guard let partialQuiz = quiz,
              let name = partialQuiz.name,
              let description = partialQuiz.description,
              let difficulty = partialQuiz.difficulty,
              let questions = partialQuiz.questions,
              let timer = partialQuiz.timer
        else { return nil }
        
        let fullQuestions: [QuizQuestion] = questions.compactMap { pq in
            guard let options: [QuizOption] = pq.options?.compactMap({ opt in
                guard let name = opt.name, let isCorrect = opt.isCorrect else { return nil }
                return QuizOption(name: name, isCorrect: isCorrect)
            }),
                  let format = pq.format,
                  let question = pq.question,
                  let title = pq.title,
                  let price = pq.price,
                  let hint = pq.hint,
                  let explanation = pq.explanation else { return nil }
            
            return QuizQuestion(
                format: format,
                question: question,
                title: title,
                options: options,
                price: price,
                hint: hint,
                explanation: explanation,
                selectedAnswer: nil
            )
        }
        let convertedQuiz = Quiz(
            name: name,
            description: description,
            difficulty: difficulty,
            questions: fullQuestions,
            timer: timer
        )
        return convertedQuiz
    }
    
    internal func prewarm() {
        session.prewarm()
    }
}
