//
//  QuizQuestionModel.swift
//  LiquidQuiz
//
//  Created by Roman Tverdokhleb on 13/06/2025.
//

import Foundation
import FoundationModels

@Generable
struct QuizQuestion: Identifiable, Codable, Hashable {
    var id = UUID()
    
    @Guide(description: "The format of the question that corresponds to the test topic.", .anyOf(QuizQuestion.Format.allCases.map(\.rawValue)))
    var format: String
    
    @Guide(description: "A question about an interesting fact that corresponds to the test topic.")
    var question: String
    
    @Guide(description: "A short based idea or fact of the question exactly in 1-2 words. Not a question or answer format.")
    var title: String
    
    @Guide(description: "Possible different answers to a question where there is only one correct answer. The answer must be 100% correct to the question. No multiple selection or answers.", .count(2...4))
    var options: [QuizOption]
    
    @Guide(description: "A reward for correct answer. The more difficult the question, the higher the value.", .range(10...100))
    var price: Int
    
    @Guide(description: "A short, concise hint for the answer, no more than 3 words.")
    var hint: String
    
    @Guide(description: "A short explanation of the correct answer to the question.")
    var explanation: String
    
    var selectedAnswer: QuizOption? = nil
    
    internal var isSelectedAnswerEmpty: Bool {
        selectedAnswer == nil
    }
    
    mutating internal func setSelectedAnswer(_ answer: QuizOption) {
        self.selectedAnswer = answer
    }
    
    enum CodingKeys: CodingKey {
        case question, format
        case title, options
        case price, hint, explanation
    }
}

extension QuizQuestion {
    internal static var sampleData: [QuizQuestion] {
        let first = QuizQuestion(
            format: "Fill in the black",
            question: "Grandma knows lots of tales, so why don't you ask her to ___?",
            title: "Tell a story",
            options: [
                QuizOption(name: "tell you a story", isCorrect: true),
                QuizOption(name: "read the menu", isCorrect: false),
                QuizOption(name: "give you directions", isCorrect: false),
                QuizOption(name: "do your homework", isCorrect: false)
            ],
            price: 3,
            hint: "Who are you?",
            explanation: "What's your name.")
        
        let second = QuizQuestion(
            format: "Complete the sentence",
            question: "Where do you live?",
            title: "Place",
            options: [
                QuizOption(name: "Moscow", isCorrect: false),
                QuizOption(name: "Saint Petersburg", isCorrect: true),
                QuizOption(name: "Yekaterinburg", isCorrect: false),
                QuizOption(name: "Nizhny Novgorod", isCorrect: false)
            ],
            price: 5,
            hint: "Place where you live.",
            explanation: "Your hometown.")
        
        let third = QuizQuestion(
            format: "Fill in the black",
            question: "Grandma knows lots of tales, so why don't you ask her to ___?",
            title: "Tell a story",
            options: [
                QuizOption(name: "tell you a story", isCorrect: true),
                QuizOption(name: "read the menu", isCorrect: false),
                QuizOption(name: "give you directions", isCorrect: false),
                QuizOption(name: "do your homework", isCorrect: false)
            ],
            price: 3,
            hint: "Who are you?",
            explanation: "What's your name.")
        
        return [first, second, third]
    }
}
