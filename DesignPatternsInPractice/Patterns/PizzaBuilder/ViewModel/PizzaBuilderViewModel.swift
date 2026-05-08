//
//  PizzaBuilderViewModel.swift
//  DesignPatternsInPractice
//
//  Created by Chetan purohit on 08/05/26.
//

import SwiftUI
import Combine

enum PizzaBuilderStep: Int, CaseIterable {
    case size, crust, toppings, summary
}

class PizzaBuilderViewModel: ObservableObject {
    @Published var builder = PizzaBuilder()
    @Published var currentStep: PizzaBuilderStep = .size
    
    func goToCrust() {
        withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
            currentStep = .crust
        }
    }
    func goToToppings() {
        withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
            currentStep = .toppings
        }
    }
    
    func finish() {
        withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
            currentStep = .summary
        }
    }
    
    func reset() {
        builder = PizzaBuilder()
        currentStep = .size
    }
}
