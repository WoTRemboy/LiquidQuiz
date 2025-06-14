//
//  ProgressBarView.swift
//  LiquidQuiz
//
//  Created by Roman Tverdokhleb on 12/06/2025.
//

import SwiftUI

struct ProgressBarView: View {
    
    private let progress: CGFloat
    private let cornerRadius: CGFloat = 10
    private let offset: CGFloat = 8
    
    init(progress: Double) {
        self.progress = CGFloat(progress)
    }
    
    internal var body: some View {
        progressBar
    }
    
    private var progressBar: some View {
        GeometryReader { proxy in
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(.gray.opacity(0.1))
                .frame(width: proxy.size.width,
                       height: proxy.size.height)
            
                .overlay(alignment: .leading) {
                    overlay(size: proxy.size)
                }
                .glassEffect(.regular.interactive())
        }
        
    }
    
    private func overlay(size: CGSize) -> some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(.green)
            .frame(width: widthSetup(for: size),
                   height: size.height - offset)
            .padding(.horizontal, 4)
    }
    
    private func widthSetup(for size: CGSize) -> CGFloat {
        if progress > 0 {
            return progress * size.width - offset
        } else {
            return 0
        }
    }
}

#Preview {
    ProgressBarView(progress: 0.6)
        .frame(height: 20)
        .padding(.horizontal)
}
