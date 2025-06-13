//
//  GlassContainerButtons.swift
//  LiquidQuiz
//
//  Created by Roman Tverdokhleb on 11/06/2025.
//

import SwiftUI

struct GlassContainerButtons: View {
    
    @EnvironmentObject private var viewModel: CreateQuizViewModel
    
    private let namespace: Namespace.ID
    
    init(namespace: Namespace.ID) {
        self.namespace = namespace
    }
    
    internal var body: some View {
        GlassEffectContainer {
            HStack {
                GlassUnionButtons(namespace: namespace)
                
                Spacer()
                GlassDynamicButtons(namespace: namespace)
            }
        }
    }
}

#Preview {
    GlassContainerButtons(namespace: Namespace().wrappedValue)
        .environmentObject(CreateQuizViewModel())
}
