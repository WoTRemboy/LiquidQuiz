//
//  Texts.swift
//  LiquidQuiz
//
//  Created by Roman Tverdokhleb on 11/06/2025.
//

import Foundation

struct Texts {
    enum AppInfo {
        static let title = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ?? "Liquidia"
    }
    
    enum OnboardingPage {
        static let skip = "Skip"
        static let next = "Next"
        static let begin = "Begin"
        static let forbidden = "Unavailable"
        static let permission = "Allow"
        static let skipPermission = "Later"
        
        enum FirstPage {
            static let title = "Welcome!"
            static let description = "Test your knowledge against AI.\nEach attempt is unique."
        }
        enum SecondPage {
            static let title = "Career"
            static let description = "Take quizzes and earn rewards.\nUnlock new content as you progress."
        }
        enum ThirdPage {
            static let title = "Friends"
            static let description = "Team up or compete to see who's best.\nMake as many friends as you can."
        }
        enum FourthPage {
            static let title = "Notifications"
            static let description = "Helps keep up with your progress.\nStay informed about energy restoration."
        }
        
        enum NotificationsAlert {
            static let title = "Notifications Access Denied"
            static let content = "To continue, allow access in Settings."
            static let settings = "Settings"
            static let cancel = "Cancel"
        }
    }
    
    enum QuizGenerate {
        static let title = "Quiz"
        static let textField = "e.g. Countries"
        static let random = "Suggest"
        static let generate = "Generate"
        static let slider = "Questions Count"
        static let difficulty = "Difficulty"
        
        static let roadmap = "Roadmap"
        static let price = "Price"
        static let generating = "Generating"
        static let begin = "Begin"
        
        enum GenerateErrorAlert {
            static let title = "Retry in 10 seconds"
            static let message = "The Quiz could not be generated. Please try again."
            static let unsupportedLanguageMessage = "This language is not supported by Apple Intelligence yet."
            static let invalidGeneratedQuizMessage = "The generated quiz did not meet the requirements. Please regenerate it."
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
                static let message = "Apple Intelligence is still downloading the model. Keep the device online and try again later."
            }
            
            enum NotEligible {
                static let title = "Device Not Eligible"
                static let message = "Apple Intelligence is not supported on this Device. Try a demo quiz instead."
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
    
    enum GlassEffectId {
        enum Onboarding {
            static let permission = "OnboardingPermissionGlassEffect"
            static let skipPermission = "OnboardingSkipPermissionGlassEffect"
        }
    }
    
    enum UserDefaults {
        static let skipOnboarding = "SkipOnboardingStage"
    }
}
