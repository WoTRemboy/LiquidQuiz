//
//  QuizInfoView.swift
//  LiquidQuiz
//
//  Created by Roman Tverdokhleb on 15/06/2025.
//

import SwiftUI
import OSLog
import FoundationModels

private let logger = Logger(subsystem: "com.liquidquiz.quiz", category: "QuizInfoView")

struct QuizInfoView: View {
    @EnvironmentObject private var appRouter: AppRouter
    
    @State private var isResponding: Bool = true
    @State private var isGenerated: Bool = false
    @State private var showErrorAlert: Bool = false
    
    @State private var generateManager: QuizGenerationManager?
    @State private var generationTask: Task<Void, Never>? = nil
    
    @Namespace private var namespace
    
    private let topic: String
    private let count: Int
    private let difficulty: Quiz.Difficulty
    
    init(topic: String, count: Int, difficulty: Quiz.Difficulty) {
        self.topic = topic
        self.count = count
        self.difficulty = difficulty
    }
        
    internal var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            if let quiz = generateManager?.quiz {
                QuizGenerateInfoView(quiz: quiz, namespace: namespace)
                
                if let questions = quiz.questions {
                    segmentLabel
                    ForEach(questions) { question in
                        LazyVStack {
                            QuizGenerateQuestionView(
                                question: question,
                                namespace: namespace)
                        }
                    }
                }
            }
            QuizGenerateProgressView(
                title: title,
                namespace: namespace,
                manager: $generateManager,
                isResponding: $isResponding)
            .padding(.top, 10)
        }
        .scrollBounceBehavior(.basedOnSize, axes: [.vertical])
        
        .navigationTitle(title)
        .toolbarTitleDisplayMode(.inlineLarge)
        .navigationBarBackButtonHidden()
        
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        
        .animation(.easeInOut, value: isResponding)
        .animation(.easeInOut, value: generateManager?.quiz)
        
        .safeAreaInset(edge: .bottom) {
            bottomButtonView
        }
        
        .onDisappear {
            generationTask?.cancel()
        }
        .alert(Texts.QuizGenerate.GenerateErrorAlert.title, isPresented: $showErrorAlert, actions: {
            Button(Texts.QuizGenerate.GenerateErrorAlert.button, role: .cancel) {
                appRouter.popToRoot(in: .create)
            }
        }, message: {
            Text(Texts.QuizGenerate.GenerateErrorAlert.message)
        })
        
        .task {
            if !isGenerated {
                generateManager = QuizGenerationManager()
                generateManager?.prewarm()
                
                do {
                    try await Task.sleep(nanoseconds: 500_000_000)
                } catch {
                    logger.error("Timer Sleep setup error: \(error.localizedDescription)")
                }
                generationTask = Task {
                    await requestItinerary()
                }
            }
        }
    }
    
    private var segmentLabel: some View {
        Text(Texts.QuizGenerate.roadmap)
            .font(.title)
            .fontWeight(.bold)
        
            .padding([.horizontal])
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var bottomButtonView: some View {
        QuizGenerationButtonsView(namespace: namespace, isResponsing: $isResponding) {
            guard let quiz = generateManager?.convertQuiz() else {
                showErrorAlert.toggle()
                logger.error("Partially Generated Quiz convertation failed")
                return
            }
            appRouter.push(.quizSelf(quiz: quiz), in: .create)
        } regenerate: {
            generationTask?.cancel()
            logger.info("Quiz is regenerating...")
            generationTask = Task {
                await requestItinerary()
            }
        } dismiss: {
            appRouter.pop(in: .create)
        }
        .padding()
    }
    
    private var title: String {
        if let quiz = generateManager?.quiz, let origTitle = quiz.name {
            return origTitle.replacingOccurrences(of: "Quiz", with: "").trimmingCharacters(in: .whitespacesAndNewlines)
        }
        return String()
    }
    
    private func requestItinerary() async {
        isResponding = true
        do {
            try await generateManager?.generateQuiz(for: topic, count: count, difficulty: difficulty)
            isResponding = false
            isGenerated = true
            logger.info("Quiz generated successfully")
        } catch {
            showErrorAlert = true
            logger.error("Generate Quiz error: \(error.localizedDescription)")
        }
    }
}

#Preview {
    QuizInfoView(topic: "Towns", count: 3, difficulty: .easy)
        .environmentObject(AppRouter())
}
