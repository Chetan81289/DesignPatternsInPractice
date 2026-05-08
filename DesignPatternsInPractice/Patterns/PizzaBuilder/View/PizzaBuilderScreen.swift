//
//  PizzaBuilderScreen.swift
//  DesignPatternsInPractice
//
//  Created by Chetan purohit on 08/05/26.
//

import SwiftUI
import Combine

// MARK: - Main Screen

struct PizzaBuilderScreen: View {
    @StateObject private var viewModel = PizzaBuilderViewModel()
    @Namespace private var animationNamespace

    var body: some View {
        VStack(spacing: 0) {
            // Step progress bar
            HStack(spacing: 0) {
                ForEach(PizzaBuilderStep.allCases, id: \.self) { step in
                    Circle()
                        .fill(step.rawValue <= viewModel.currentStep.rawValue ? Color.orange : Color.gray.opacity(0.3))
                        .frame(width: 12, height: 12)
                    if step != .summary {
                        Rectangle()
                            .fill(step.rawValue < viewModel.currentStep.rawValue ? Color.orange : Color.gray.opacity(0.3))
                            .frame(height: 2)
                            .frame(maxWidth: .infinity)
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 16)

            // Current step content – uses matchedGeometryEffect for seamless transition
            ZStack {
                switch viewModel.currentStep {
                case .size:
                    SizeStepView(selectedSize: $viewModel.builder.size, action: viewModel.goToCrust)
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                case .crust:
                    CrustStepView(selectedCrust: $viewModel.builder.crust, action: viewModel.goToToppings)
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                case .toppings:
                    ToppingsStepView(
                        selectedToppings: $viewModel.builder.toppings,
                        builder: viewModel.builder,
                        action: viewModel.finish
                    )
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                case .summary:
                    SummaryPizzaView(pizza: viewModel.builder.build(), resetAction: viewModel.reset)
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                }
            }
            .animation(.spring(response: 0.4, dampingFraction: 0.7), value: viewModel.currentStep)
            .padding(.vertical)
        }
        .navigationTitle("Custom Pizza")
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
    }
}
