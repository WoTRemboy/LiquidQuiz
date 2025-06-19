//
//  Texts.swift
//  LiquidQuiz
//
//  Created by Roman Tverdokhleb on 11/06/2025.
//

import Foundation

struct Texts {
    enum QuizGenerate {
        static let title = "Quiz"
        static let textField = "ex. Countries"
        static let random = "Suggest"
        static let generate = "Generate"
        static let slider = "Questions Count"
        static let difficulty = "Difficulty"
        
        static let roadmap = "Roadmap"
        static let price = "Price"
        static let generating = "Generating"
        static let begin = "Begin"
        
        enum GenerateErrorAlert {
            static let title = "Error"
            static let message = "The Quiz could not be generated. Please try again."
            static let button = "Return"
        }
        
        enum ModelStatusAlert {
            static let demo = "Demo"
            static let cancel = "OK"
            
            enum NotEnabled {
                static let title = "AI Not Enabled"
                static let message = "Apple Intelligence is turned off. Enable it in Settings."
            }
            
            enum NotReady {
                static let title = "Model Not Ready"
                static let message = "Try again later."
            }
            
            enum NotEligible {
                static let title = "Device Not Eligible"
                static let message = "Apple Intelligence is not supported on this Device. Try a mock quiz instead."
            }
        }
    }
    
    enum QuizSelf {
        enum Toolbar {
            static let title = "Quiz Topic"
            static let score = "Score"
        }
        enum ConfirmDialog {
            static let title = "Exit the quiz?"
            static let message = "All progress will be lost."
            static let confirm = "Confirm"
        }
    }
    
    enum QuizResults {
        static let close = "Return"
    }
    
    enum Tabbar {
        static let create = "Create"
    }
    
    enum Namespace {
        enum QuizGenerate {
            static let clear = "QuizGenerateClear"
            static let random = "QuizGenerateRandom"
            static let generate = "QuizGenerateGenerate"
            static let container = "QuizGenerateContainer"
            
            static let description = "QuizGenerateDescription"
            static let count = "QuizGenerateCount"
            static let difficulty = "QuizGenerateDifficulty"
            static let timer = "QuizGenerateTimer"
            static let titlePrice = "QuizGenerateTitlePrice"
            
            static let titleFormat = "QuizGenerateTitleFormat"
            static let questionPrice = "QuizGenerateQuestionPrice"
            
            static let backButton = "QuizGenerateBackButton"
            static let regenerateButton = "QuizGenerateRegenerateButton"
            static let beginButton = "QuizGenerateBeginButton"
        }
        
        enum QuizSelf {
            static let option = "QuizSelfOption"
            static let explanation = "QuizSelfExplanation"
            static let container = "QuizSelfContainer"
        }
        
        enum QuizResults {
            static let score = "QuizResultsScore"
            static let timer = "QuizResultsTimer"
        }
    }
}
