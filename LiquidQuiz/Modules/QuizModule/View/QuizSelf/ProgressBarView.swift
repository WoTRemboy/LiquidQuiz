//
//  ProgressBarView.swift
//  LiquidQuiz
//
//  Created by Roman Tverdokhleb on 12/06/2025.
//

import SwiftUI

struct ProgressBarView: View {
    
    private let question: Int
    private let total: Int
    private let progress: CGFloat
    
    private let cornerRadius: CGFloat = 10
    private let offset: CGFloat = 8
    
    init(current: Int, total: Int) {
        self.question = current
        self.total = total
        self.progress = CGFloat(current) / CGFloat(total)
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
            .frame(width: progress * size.width - offset,
                   height: size.height - offset)
            .padding(.horizontal, 4)
    }
}

#Preview {
    ProgressBarView(current: 5, total: 10)
        .frame(height: 20)
        .padding(.horizontal)
}
