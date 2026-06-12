//
//  QuizModel.swift
//  LiquidQuiz
//
//  Created by Roman Tverdokhleb on 12/06/2025.
//

import Foundation
import FoundationModels

@Generable
struct Quiz: Codable, Equatable, Hashable {
    var id = UUID()
    
    @Guide(description: "Quiz topic name, 1 to 3 words. Do not include the word \"Quiz\". Use the same language as the user's topic.")
    var name: String
    
    @Guide(description: "Two short sentences that explain what the quiz covers. Use the same language as the user's topic.")
    var description: String
    
    var difficulty: Quiz.Difficulty
    var questions: [QuizQuestion]
    
    @Guide(description: "Quiz duration in seconds. Base it on question count and difficulty: more questions or higher difficulty means more time.", .range(30...300))
    var timer: Int
    
    var currentQuestionIndex: Int = 0
    
    mutating internal func increaseQuestionIndex() {
        currentQuestionIndex += 1
    }
    
    var correctAnswers: Int = 0
    
    mutating internal func increaseCorrectAnswers() {
        correctAnswers += 1
    }
    
    enum CodingKeys: CodingKey {
        case name, description, difficulty
        case questions, timer
    }
    
    static internal var sampleData: Quiz {
        Quiz(
            name: "Space Exploration",
            description: "Test your knowledge about the wonders of space exploration. This quiz covers iconic astronauts, historic missions, celestial objects, and facts about our universe. Great for anyone curious about outer space!",
            difficulty: .normal,
            questions: QuizQuestion.sampleData,
            timer: 120
        )
    }
}
