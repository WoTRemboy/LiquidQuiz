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
            format: "Answer the question",
            question: "Who was the first person to walk on the Moon?",
            title: "First Moonwalker",
            options: [
                QuizOption(name: "Neil Armstrong", isCorrect: true),
                QuizOption(name: "Buzz Aldrin", isCorrect: false),
                QuizOption(name: "Yuri Gagarin", isCorrect: false)
            ],
            price: 20,
            hint: "Apollo 11",
            explanation: "Neil Armstrong walked on the Moon in 1969 during Apollo 11.")

        let second = QuizQuestion(
            format: "Choose a synonym",
            question: "Which word is a synonym for 'astronaut'?",
            title: "Astronaut Synonym",
            options: [
                QuizOption(name: "Cosmonaut", isCorrect: true),
                QuizOption(name: "Biologist", isCorrect: false),
                QuizOption(name: "Geologist", isCorrect: false)
            ],
            price: 15,
            hint: "Russian term",
            explanation: "'Cosmonaut' is the Russian word for astronaut.")

        let third = QuizQuestion(
            format: "Fill in the blank",
            question: "The first artificial satellite was called ____.",
            title: "First Satellite",
            options: [
                QuizOption(name: "Sputnik 1", isCorrect: true),
                QuizOption(name: "Voyager 1", isCorrect: false),
                QuizOption(name: "Apollo 13", isCorrect: false)
            ],
            price: 18,
            hint: "Launched by USSR",
            explanation: "Sputnik 1 was launched by the Soviet Union in 1957.")

        let fourth = QuizQuestion(
            format: "Select the definition",
            question: "What is a 'comet'?",
            title: "Comet Definition",
            options: [
                QuizOption(name: "A celestial object made of ice and dust", isCorrect: true),
                QuizOption(name: "A large planet", isCorrect: false),
                QuizOption(name: "A kind of star", isCorrect: false)
            ],
            price: 18,
            hint: "Tail in the sky",
            explanation: "Comets are icy objects that develop tails when near the Sun.")

        let fifth = QuizQuestion(
            format: "Complete the sentence",
            question: "Mars is often called the ______ planet.",
            title: "Mars Nickname",
            options: [
                QuizOption(name: "Red", isCorrect: true),
                QuizOption(name: "Blue", isCorrect: false),
                QuizOption(name: "Green", isCorrect: false)
            ],
            price: 15,
            hint: "Color of Mars",
            explanation: "Mars is called the Red Planet due to its appearance.")

        return [first, second, third, fourth, fifth]
    }
}
