//
//  CreateQuizTests.swift
//  LiquidQuiz
//
//  Created by Roman Tverdokhleb on 29/06/2025.
//

import Testing
@testable import LiquidQuiz

@Suite("CreateQuizViewModel Behavior")
struct CreateQuizViewModelTests {
    @Test("Quiz topic is set correctly")
    func testSetQuizTopic() async throws {
        let vm = await CreateQuizViewModel()
        #expect(vm.quizTopic.isEmpty)
        
        await vm.setQuizTopic("Astronomy")
        #expect(vm.quizTopic == "Astronomy")
        
        await vm.setQuizTopic("")
        #expect(vm.quizTopic.isEmpty)
    }

    @Test("Random topic is picked from MockTopic")
    func testRandomQuizTopic() async throws {
        let vm = await CreateQuizViewModel()
        await vm.setQuizTopic(random: true)
        #expect(!vm.quizTopic.isEmpty)
        #expect(MockTopic.allCases.contains { $0.rawValue == vm.quizTopic })
    }

    @Test("Quiz topic empty state is reported correctly")
    func testIsQuizTopicEmpty() async throws {
        let vm = await CreateQuizViewModel()
        #expect(vm.isQuizTopicEmpty == true)
        
        await vm.setQuizTopic("History")
        #expect(vm.isQuizTopicEmpty == false)
    }

    @Test("Slider and difficulty expansion toggles are mutually exclusive")
    func testSliderAndDifficultyExpandedMutualExclusion() async throws {
        let vm = await CreateQuizViewModel()
        #expect(vm.isSliderExpanded == false)
        #expect(vm.isDifficultyExpanded == false)
        
        await vm.isSliderExpandedToggle()
        #expect(vm.isSliderExpanded == true)
        #expect(vm.isDifficultyExpanded == false)
        
        await vm.isDifficultyExpandedToggle()
        #expect(vm.isSliderExpanded == false)
        #expect(vm.isDifficultyExpanded == true)
    }

    @Test("Difficulty is set and expands as expected")
    func testSetDifficulty() async throws {
        let vm = await CreateQuizViewModel()
        #expect(vm.quizDifficulty == .normal)
        
        await vm.setQuizDifficulty(to: .hard)
        #expect(vm.quizDifficulty == .hard)
        #expect(vm.isDifficultyExpanded == true)
        #expect(vm.isSliderExpanded == false)
    }

    @Test("Question count label and range formatting")
    func testQuestionCountLabels() async throws {
        let vm = await CreateQuizViewModel()
        await MainActor.run { vm.questionCount = 4.0 }
        #expect(vm.questionCountLabel == "4")
        
        let rangeStart = await vm.questionCountRange(for: .begin)
        let rangeEnd = await vm.questionCountRange(for: .end)
        #expect(!rangeStart.isEmpty && !rangeEnd.isEmpty)
    }

    @Test("Error alert is shown and content is correct for unavailable model")
    func testModelStatusErrorHandling() async throws {
        let vm = await CreateQuizViewModel()
        #expect(vm.isErrorAlertShown == false)
        #expect(vm.errorAlertContent.title.isEmpty)
        #expect(vm.errorAlertContent.content.isEmpty)
    }
}

