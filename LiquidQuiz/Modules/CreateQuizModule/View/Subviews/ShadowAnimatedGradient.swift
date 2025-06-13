//
//  ShadowAnimatedGradient.swift
//  LiquidQuiz
//
//  Created by Roman Tverdokhleb on 11/06/2025.
//

import SwiftUI

struct ShadowAnimatedGradient: View {
    
    @State private var isAnimated: Bool = false
    
    internal var body: some View {
        RoundedRectangle(cornerRadius: 30, style: .continuous)
            .fill(gradient)
            .blur(radius: 5)
            .onAppear {
                withAnimation(.linear(duration: 7).repeatForever(autoreverses: false)) {
                    isAnimated = true
                }
            }
    }
    
    private var gradient: AngularGradient {
        AngularGradient(
            colors: [
                Color.Gradient.blue,
                Color.Gradient.mint,
                Color.Gradient.lavender,
                Color.Gradient.peach,
                Color.Gradient.yellow
            ],
            center: .center,
            angle: .degrees(isAnimated ? 360 : 0)
        )
    }
}

#Preview {
    ShadowAnimatedGradient()
}
