//
//  SplashScreenView.swift
//  LiquidQuiz
//
//  Created by Roman Tverdokhleb on 25/12/2025.
//

import SwiftUI

struct SplashScreenView: View {
    
    // MARK: - Properties
    
    // Show splash screen toggle
    @State private var isActive = false
    @State private var id = 0
    
    private let texts = [String(), Texts.AppInfo.title]
    
    // MARK: - Body view
    
    internal var body: some View {
        if isActive {
            // Step to the main view
            OnboardingScreenView()
        } else {
            // Shows splash screen
            content
                .onAppear {
                    // Then hides view after 1s
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        withAnimation {
                            self.isActive = true
                        }
                    }
                }
        }
    }
    
    // MARK: - Main vontent
    
    private var content: some View {
        VStack(spacing: 50) {
            Image.Onboarding.logo
                .resizable()
                .scaledToFit()
                .padding(.horizontal, 100)
            
            Text(texts[id])
                .foregroundStyle(Color.LabelColors.primary)
                .font(.system(size: 80, weight: .medium))
                .lineLimit(1)
                .minimumScaleFactor(0.7)
                .padding(.horizontal, 30)
        }
        .contentTransition(.numericText())
        // Background behaviour
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Color.BackgroundColors.primary
        )
        // Navigation timer setup
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { timer in
                withAnimation {
                    id += 1
                }
            }
        }
    }
}

// MARK: - Preview

#Preview {
    SplashScreenView()
}
