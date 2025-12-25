//
//  OnboardingScreenView.swift
//  LiquidQuiz
//
//  Created by Roman Tverdokhleb on 25/12/2025.
//

import SwiftUI
import SwiftUIPager

struct OnboardingScreenView: View {
    
    @StateObject private var viewModel = OnboardingViewModel()
    
    /// Current page tracker for the pager.
    @StateObject private var page: Page = .first()
    
    @State private var draw: Bool = false
    
    @Namespace private var namespace
        
    internal var body: some View {
        if viewModel.skipOnboarding {
            ContentView()
                .environmentObject(AppRouter())
        } else {
            VStack(alignment: .trailing) {
                skipButton
                content
                progressCircles
                actionButtons
            }
            .onChange(of: page.index) { _, newValue in
                withAnimation {
                    viewModel.setupCurrentStep(newValue: newValue)
                }
            }
            .background(Color.BackgroundColors.primary)
            .task {
                viewModel.triggerDrawOnSymbol(0)
            }
            .onChange(of: page.index) { oldValue, newValue in
                viewModel.triggerDrawOnSymbol(newValue)
            }
            .alert(Texts.OnboardingPage.NotificationsAlert.title, isPresented: $viewModel.showNotificationsPermissionAlert) {
                notificationsAlertButtons
            } message: {
                Text(Texts.OnboardingPage.NotificationsAlert.content)
            }
        }
    }
    
    private var skipButton: some View {
        OnboardingSkipButton(viewModel: viewModel, show: !viewModel.isLastPage) {
            page.update(.moveToLast)
        }
    }
    
    private var content: some View {
        Pager(page: page,
              data: viewModel.pages,
              id: \.self) { index in
            VStack(spacing: 16) {
                animatedImage(for: index)
                
                Text(viewModel.steps[index].name)
                    .font(.largeTitle(.bold))
                    .padding(.top)
                
                Text(viewModel.steps[index].description)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)
                    .lineLimit(2)
            }
            .foregroundStyle(Color.LabelColors.primary)
            .tag(index)
        }
              .interactive(scale: 0.8)
              .itemSpacing(10)
              .itemAspectRatio(1.0)
        
              .swipeInteractionArea(.allAvailable)
              .multiplePagination()
              .horizontal()
    }
    
    @ViewBuilder
    private func animatedImage(for index: Int) -> some View {
        let iconSize: CGFloat = hasNotch() ? 250 : 200
        if viewModel.steps[index].drawOn {
            viewModel.steps[index].image
                .resizable()
                .scaledToFit()
                .symbolRenderingMode(.palette)
                .foregroundStyle(
                    Color.SupportColors.orange,
                    Color.SupportColors.lightBlue
                )
                .frame(width: iconSize, height: iconSize)
                .transition(.symbolEffect(.drawOn.individually))
        } else {
            Color.clear
                .frame(width: iconSize, height: iconSize)
        }
    }
    
    private var progressCircles: some View {
        HStack {
            ForEach(viewModel.pages, id: \.self) { step in
                if step == page.index {
                    Circle()
                        .frame(width: 15, height: 15)
                        .foregroundStyle(Color.SupportColors.lightBlue)
                        .transition(.scale)
                } else {
                    Circle()
                        .frame(width: 10, height: 10)
                        .foregroundStyle(Color.LabelColors.disable)
                        .transition(.scale)
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
    
    private var actionButtons: some View {
        OnboardingActionButtonsView(
            viewModel: viewModel,
            namespace: namespace) {
                withAnimation {
                    page.update(.next)
                }
            }
    }
    
    @ViewBuilder
    private var notificationsAlertButtons: some View {
        Button(Texts.OnboardingPage.NotificationsAlert.settings) {
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url)
            }
        }
        Button(Texts.OnboardingPage.NotificationsAlert.cancel, role: .cancel) {}
    }
}

#Preview {
    OnboardingScreenView()
}
