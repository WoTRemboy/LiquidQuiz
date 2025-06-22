<div align="center">
  <img src="https://github.com/user-attachments/assets/ee577988-b80b-408b-a785-5da768c1130c" alt="App Icon" width="200" height="200">
  <h1>Liquidia: AI Glass Quiz</h1>
</div>

**Liquidia** is a Swift-based iOS app for creating and playing quizzes. It features dynamic quiz generation, engaging UI, hints, progress tracking, and result breakdowns—all in a modern, smooth user experience.
Watch a [Demo](https://drive.google.com/file/d/1nlFE98Kz_IPkBwxZyQe5cSJcQU4Y-B_L/view?usp=sharing). Find in [TestFlight](https://testflight.apple.com/join/Q9NC7mxU).

## Table of Contents 📋
- [Features](#features)
- [Technologies](#technologies)
- [Architecture](#architecture)
- [Requirements](#requirements)

<h2 id="features">Features ⚒️</h2>

### Quiz Creation & Selection
- Create new quizzes with customizable topics and difficulty
- Browse received quizzes and view quiz details
- Each quiz includes a timer, description, and set of dynamic questions

<img src="https://github.com/user-attachments/assets/50cfc95e-f8e0-4ed4-b46e-55d7b38029f7" alt="Quiz Generation Demo" width="200" height="435">
<img src="https://github.com/user-attachments/assets/ed6ed4c4-5f16-48c6-97d0-0b985996c23e" alt="Main Page" width="200" height="435">
<img src="https://github.com/user-attachments/assets/90664da4-8406-4372-8ffc-fa48f80f4b6f" alt="Quiz Info" width="200" height="435">

### Quiz Taking Experience
- Answer single or multiple-choice questions
- Timer, progress bar, and score display during the quiz
- Hints available for each question
- Seamless navigation between questions with animated transitions
- Immediate feedback on selected answers, with color-coded correctness

<img src="https://github.com/user-attachments/assets/9b98a9a3-682e-4419-b01e-61229695f085" alt="Quiz Taking Demo" width="200" height="435">
<img src="https://github.com/user-attachments/assets/2306ae5e-5f36-4e27-9dc0-ac5f06250e1f" alt="Wrong Answer" width="200" height="435">
<img src="https://github.com/user-attachments/assets/065cb231-85d2-41cb-b6f2-607cd7f4b894" alt="Correct Answer" width="200" height="435">

### Results & Review
- Score and time statistics per quiz attempt
- Animated result reveal and percent progress

<img src="https://github.com/user-attachments/assets/fc805568-3bb2-441d-a354-748b6a4b410d" alt="Results Page Demo" width="200" height="435">
<img src="https://github.com/user-attachments/assets/917c8193-d2be-4a50-92f4-3c26fe3a7afa" alt="Results Page" width="200" height="435">

### Modern UI & Navigation
- Liquid Glass design and dynamic visual feedback
- Single-tab navigation with custom router
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

<h2 id="requirements">Requirements ✅</h2>

- Xcode 26.0+
- Swift 5.9+
- iOS 26.0+
- Apple Intelligence Enabled
