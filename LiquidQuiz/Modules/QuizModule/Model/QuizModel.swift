//
//  QuizModel.swift
//  LiquidQuiz
//
//  Created by Roman Tverdokhleb on 12/06/2025.
//

import Foundation

struct QuizQuestion: Identifiable, Codable {
    var id = UUID()
    var price: Int
    var question: String
    var options: [String]
    var answer: String
    var hint: String
    var explanation: String
    
    var tappedAnswer: String = ""
    
    enum CodingKeys: CodingKey {
        case price, question, options, answer
        case hint, explanation
    }
    
    internal static var sampleData: [QuizQuestion] {
        let first = QuizQuestion(
            price: 3,
            question: "What is your name?",
            options: ["Roman", "John", "Alex", "Max"],
            answer: "Roman",
            hint: "Who are you?",
            explanation: "What's your name.")
        let second = QuizQuestion(
            price: 5,
            question: "Where do you live?",
            options: ["Moscow", "Saint Petersburg", "Yekaterinburg", "Nizhny Novgorod"],
            answer: "Saint Petersburg",
            hint: "Place where you live.",
            explanation: "Your hometown.")
        return [first, second]
    }
}
