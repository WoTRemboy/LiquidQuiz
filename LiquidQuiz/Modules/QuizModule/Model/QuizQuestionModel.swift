//
//  QuizQuestionModel.swift
//  LiquidQuiz
//
//  Created by Roman Tverdokhleb on 13/06/2025.
//

import Foundation

struct QuizQuestion: Identifiable, Codable {
    var id = UUID()
    var question: String
    var format: String
    
    var options: [QuizOption]
    var price: Int
    
    var hint: String
    var explanation: String
    
    var selectedAnswer: QuizOption? = nil
    
    internal var isSelectedAnswerEmpty: Bool {
        selectedAnswer == nil
    }
    
    mutating internal func setSelectedAnswer(_ answer: QuizOption) {
        self.selectedAnswer = answer
    }
    
    enum CodingKeys: CodingKey {
        case question, format, options
        case price, hint, explanation
    }
    
    internal static var sampleData: [QuizQuestion] {
        let first = QuizQuestion(
            question: "Grandma knows lots of tales, so why don't you ask her to ___?",
            format: "Fill in the black",
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
            question: "Where do you live?",
            format: "Complete the sentence",
            options: [
                QuizOption(name: "Moscow", isCorrect: false),
                QuizOption(name: "Saint Petersburg", isCorrect: true),
                QuizOption(name: "Yekaterinburg", isCorrect: false),
                QuizOption(name: "Nizhny Novgorod", isCorrect: false)
            ],
            price: 5,
            hint: "Place where you live.",
            explanation: "Your hometown.")
        return [first, second]
    }
}

