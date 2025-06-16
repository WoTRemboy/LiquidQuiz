//
//  QuizQuestionFormatModel.swift
//  LiquidQuiz
//
//  Created by Roman Tverdokhleb on 15/06/2025.
//

import FoundationModels

extension QuizQuestion {
    
    @Generable
    enum Format: String, CaseIterable {
        case asnwerQuestion = "Answer the question"
        case fillInTheBlank = "Fill in the blank"
        case completeSentence = "Complete the sentence"
        case chooseCorrectDate = "Choose the correct date"
        case selectDefinition = "Select the definition"
        case synonymChoice = "Choose a synonym"
        case antonymChoice = "Choose an antonym"
        case selectEquation = "Select the equation"
    }
}
