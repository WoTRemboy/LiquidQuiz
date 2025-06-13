//
//  QuizModel.swift
//  LiquidQuiz
//
//  Created by Roman Tverdokhleb on 12/06/2025.
//

import Foundation

struct QuizQuestion: Identifiable, Codable {
    var id = UUID()
    var question: String
    var format: String
    
    var options: [String]
    var answer: String
    var price: Int
    
    var hint: String
    var explanation: String
    
    var tappedAnswer: String = ""
    
    enum CodingKeys: CodingKey {
        case question, format, options
        case answer, price
        case hint, explanation
    }
    
    internal static var sampleData: [QuizQuestion] {
        let first = QuizQuestion(
            question: "Grandma knows lots of tales, so why don't you ask her to ___?",
            format: "Fill in the black",
            options: ["tell you a story", "read the menu", "give you directions", "do your homework"],
            answer: "tell you a story",
            price: 3,
            hint: "Who are you?",
            explanation: "What's your name.")
        let second = QuizQuestion(
            question: "Where do you live?",
            format: "Complete the sentence",
            options: ["Moscow", "Saint Petersburg", "Yekaterinburg", "Nizhny Novgorod"],
            answer: "Saint Petersburg",
            price: 5,
            hint: "Place where you live.",
            explanation: "Your hometown.")
        return [first, second]
    }
}
