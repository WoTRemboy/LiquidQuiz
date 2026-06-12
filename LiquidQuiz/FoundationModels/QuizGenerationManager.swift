//
//  QuizGenerationManager.swift
//  LiquidQuiz
//
//  Created by Roman Tverdokhleb on 15/06/2025.
//

import OSLog
import Observation
import FoundationModels

private let logger = Logger(subsystem: "com.liquidquiz.quiz", category: "QuizGenerationManager")

@Observable
@MainActor
final class QuizGenerationManager {
    private(set) var quiz: Quiz.PartiallyGenerated?
    private var session: LanguageModelSession
    private var requestedQuestionCount: Int?
    private static let model = SystemLanguageModel.default
    
    init() {
        self.session = QuizGenerationManager.sessionSetup()
        logger.info("Quiz Generation Session created")
    }
    
    internal func generateQuiz(for name: String, count: Int, difficulty: Quiz.Difficulty) async throws {
        try QuizGenerationManager.validateModelAvailability()
        requestedQuestionCount = count
        session = QuizGenerationManager.sessionSetup()
        do {
            let stream = session.streamResponse(generating: Quiz.self) {
                """
                Generate one single-choice quiz for this topic: \(name).
                Requirements:
                - Generate exactly \(count) questions. Do not generate fewer or more.
                - Set quiz.difficulty exactly to \(difficulty.rawValue).
                - Use the same language as the topic for every generated text field.
                - Each question must have exactly one correct option where isCorrect is true.
                - All other options for the same question must have isCorrect set to false.
                - Every option must be unique, plausible, and directly related to the question.
                - Do not repeat the same fact or concept across questions.
                """
            }
            for try await partialQuiz in stream {
                quiz = limitedQuiz(partialQuiz.content, questionCount: count)
            }
            try validateGeneratedQuiz(expectedCount: count, expectedDifficulty: difficulty)
        } catch let error as LanguageModelSession.GenerationError {
            throw QuizGenerationManager.mapGenerationError(error)
        }
    }
    
    static private func sessionSetup() -> LanguageModelSession {
        LanguageModelSession {
            "Create a complete single-choice quiz that strictly follows the requested topic, question count, and difficulty."
            
            """
            Output only data that fits the requested schema.
            The quiz must contain exactly the requested number of questions.
            Every generated text field must use the same language as the user's topic.
            Each question must test one clear fact, definition, date, term, or concept from the topic.
            Questions must gradually increase in difficulty while staying within the requested difficulty level.
            Easy questions should have prices from 10 to 50.
            Normal questions should have prices from 20 to 70.
            Hard questions should have prices from 30 to 100.
            Each question must have 4 answer options and exactly one correct option.
            Mark only the correct option with isCorrect = true; mark every incorrect option with isCorrect = false.
            Answer options must be mutually exclusive, unique, and grammatically consistent with the question.
            If a question uses a blank, write the blank exactly as ____.
            """
        }
    }
    
    internal func convertQuiz() -> Quiz? {
        guard let partialQuiz = quiz,
              let name = partialQuiz.name,
              let description = partialQuiz.description,
              let difficulty = partialQuiz.difficulty,
              let generatedQuestions = partialQuiz.questions,
              let timer = partialQuiz.timer
        else { return nil }
        
        let questions = limitedQuestions(generatedQuestions)
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
        guard QuizGenerationManager.model.availability == .available else {
            logger.warning("Prewarm skipped because the model is unavailable")
            return
        }
        session.prewarm()
        logger.info("Model has been prewarmed")
    }
    
    static private func validateModelAvailability() throws {
        guard model.availability == .available else {
            throw QuizGenerationFailure.modelUnavailable(message(for: model.availability))
        }
    }
    
    static private func mapGenerationError(_ error: LanguageModelSession.GenerationError) -> Error {
        switch error {
        case .assetsUnavailable:
            QuizGenerationFailure.modelUnavailable(Texts.QuizGenerate.ModelStatusAlert.NotReady.message)
        case .unsupportedLanguageOrLocale:
            QuizGenerationFailure.unsupportedLanguage
        default:
            error
        }
    }
    
    static private func message(for availability: SystemLanguageModel.Availability) -> String {
        switch availability {
        case .available:
            String()
        case .unavailable(.appleIntelligenceNotEnabled):
            Texts.QuizGenerate.ModelStatusAlert.NotEnabled.message
        case .unavailable(.modelNotReady):
            Texts.QuizGenerate.ModelStatusAlert.NotReady.message
        case .unavailable(.deviceNotEligible):
            Texts.QuizGenerate.ModelStatusAlert.NotEligible.message
        case .unavailable:
            Texts.QuizGenerate.ModelStatusAlert.NotEligible.message
        }
    }
    
    private func limitedQuiz(_ quiz: Quiz.PartiallyGenerated, questionCount: Int) -> Quiz.PartiallyGenerated {
        var limitedQuiz = quiz
        if let questions = limitedQuiz.questions, questions.count > questionCount {
            limitedQuiz.questions = Array(questions.prefix(questionCount))
        }
        return limitedQuiz
    }
    
    private func limitedQuestions(_ questions: [QuizQuestion.PartiallyGenerated]) -> [QuizQuestion.PartiallyGenerated] {
        guard let requestedQuestionCount else {
            return questions
        }
        return Array(questions.prefix(requestedQuestionCount))
    }
    
    private func validateGeneratedQuiz(expectedCount: Int, expectedDifficulty: Quiz.Difficulty) throws {
        guard let quiz,
              quiz.difficulty == expectedDifficulty,
              let questions = quiz.questions,
              questions.count == expectedCount
        else {
            throw QuizGenerationFailure.invalidGeneratedQuiz
        }
        
        for question in questions {
            guard let options = question.options,
                  (2...4).contains(options.count)
            else {
                throw QuizGenerationFailure.invalidGeneratedQuiz
            }
            
            let optionNames = options.compactMap(\.name)
            let uniqueNames = Set(optionNames.map { $0.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() })
            let correctAnswersCount = options.filter { $0.isCorrect == true }.count
            
            guard optionNames.count == options.count,
                  uniqueNames.count == options.count,
                  correctAnswersCount == 1
            else {
                throw QuizGenerationFailure.invalidGeneratedQuiz
            }
        }
    }
    
}

private enum QuizGenerationFailure: LocalizedError {
    case modelUnavailable(String)
    case unsupportedLanguage
    case invalidGeneratedQuiz
    
    var errorDescription: String? {
        switch self {
        case .modelUnavailable(let message):
            message
        case .unsupportedLanguage:
            Texts.QuizGenerate.GenerateErrorAlert.unsupportedLanguageMessage
        case .invalidGeneratedQuiz:
            Texts.QuizGenerate.GenerateErrorAlert.invalidGeneratedQuizMessage
        }
    }
}
