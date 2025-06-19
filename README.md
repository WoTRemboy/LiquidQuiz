<div align="center">
  <img src="https://github.com/user-attachments/assets/ee577988-b80b-408b-a785-5da768c1130c" alt="App Icon" width="200" height="200">
  <h1>Liquidia: AI Glass Quiz</h1>
</div>

**Liquidia** is a Swift-based iOS app for creating and playing quizzes. It features dynamic quiz generation, engaging UI, hints, progress tracking, and result breakdowns—all in a modern, smooth user experience.
Watch a [Demo](https://drive.google.com/drive/folders/1tFTSSXiGWhrctvX1X1N4dMh4_jPgj-K1?usp=sharing). Find in [TestFlight](https://testflight.apple.com/join/Q9NC7mxU).

## Table of Contents 📋
- [Features](#features)
- [Technologies](#technologies)
- [Architecture](#architecture)
- [Testing](#testing)
- [Documentation](#documentation)
- [Requirements](#requirements)

<h2 id="features">Features ⚒️</h2>

### Quiz Creation & Selection
- Create new quizzes with customizable topics and difficulty
- Browse received quizzes and view quiz details
- Each quiz includes a timer, description, and set of dynamic questions

### Quiz Taking Experience
- Answer single or multiple-choice questions
- Timer, progress bar, and score display during the quiz
- Hints available for each question
- Seamless navigation between questions with animated transitions
- Immediate feedback on selected answers, with color-coded correctness

### Results & Review
- Score and time statistics per quiz attempt
- Animated result reveal and percent progress

### Modern UI & Navigation
- Built entirely with SwiftUI for smooth transitions and layouts
- Single-tab navigation with custom router
- Glass effect and dynamic visual feedback
- Full support for system dark mode

<h2 id="technologies">Technologies 💻</h2>

- **Swift 5.9+**: The primary language for all app logic
- **SwiftUI**: Declarative UI for all screens and navigation
- **Combine**: Reactive programming for state management and event handling
- **MVVM + Router architecture**: Separation of data, view logic, and UI
- **Foundation**: Codable for quiz data, timer logic, etc.

<h2 id="architecture">Architecture 🏗️</h2>

The app embraces the MVVM (Model-View-ViewModel) pattern:
- **Model**: `Quiz`, `QuizQuestion`, and related structs handle quiz data, scoring, and state
- **ViewModel**: `QuizViewModel` manages quiz logic, progress, timer, and score updates
- **View**: SwiftUI views such as `QuizSelfView`, `ProgressBarView`, and more render the UI and bind to view models
- **Router**: `AppRouter` handles navigation and path management

<h2 id="testing">Testing 🧪</h2>

The project is structured for easy extensibility with unit tests. Suggested tests:
- **Quiz Logic**: Validate question selection, scoring, and timer
- **ViewModel**: Test state updates for answer selection and progression

<h2 id="documentation">Documentation 📚</h2>

All significant classes, methods, and properties use Apple's DocC format for in-source documentation.
- **Description**: Explains type or method purpose
- **Parameters**: Each parameter and its role
- **Returns**: What is returned and when

Example:
```swift
/// Toggles the display of the hint popover for the current question.
internal func isShowingHintPopoverToggle() {
    isShowingHintPopover.toggle()
}
