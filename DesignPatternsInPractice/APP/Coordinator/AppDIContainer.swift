//
//  AppDIContainer.swift
//  DesignPatternsInPractice
//
//  Created by Chetan purohit on 07/05/26.
//

import Foundation
import Combine

/// Central place to register and resolve dependencies.
/// All services are created here – swap mock implementations for testing.
///
final class AppDIContainer: ObservableObject {
  
    // MARK: - Services
    // Real services (used in production)
    
    // Dummy published property required for ObservableObject conformance
    @Published private var dummy = false

    lazy var paymentService: PaymentServiceProtocol = PaymentService()
    lazy var cartService: CartServiceProtocol = CartService()

    // To use mocks for testing, change injection here
    // Override them using the test container in unit tests.
}

class PaymentService: PaymentServiceProtocol {
    func process(amount: Double, method: PaymentMethod) async throws -> String {
        try await Task.sleep(nanoseconds: 1_000_000_000)
        return "txn_\(UUID().uuidString)"
    }
}

class CartService: CartServiceProtocol {
    func fetchCart() async -> Cart {
        Cart(items: [
            CartItem(name: "Pizza Supreme", price: 12.99),
            CartItem(name: "Garlic Bread", price: 4.99)
        ])
    }
}





//enum PaymentMethod: String { case applePay, creditCard }
//struct Cart { let items: [String]; var total: Double { Double(items.count) * 12.0 } }

