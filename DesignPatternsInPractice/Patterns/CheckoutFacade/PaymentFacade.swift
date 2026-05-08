//
//  PaymentFacade.swift
//  DesignPatternsInPractice
//
//  Created by Chetan purohit on 08/05/26.
//

import Foundation

// MARK: - Complex Subsystem Classes

/// Simulates a payment processing service.
final class PaymentProcessor {
    func process(amount: Double, method: PaymentMethod) async throws -> String {
        // Simulate network delay
        try await Task.sleep(for: .seconds(2))
        return "txn_\(UUID().uuidString.prefix(8))"
    }
}

/// Simulates an address validation service.
final class AddressValidator {
    func validate(_ address: String) async throws -> String {
        // Simulate validation delay
        try await Task.sleep(for: .seconds(1))
        guard !address.trimmingCharacters(in: .whitespaces).isEmpty else {
            throw CheckoutError.invalidAddress
        }
        // Return the validated address (in real life it might be formatted)
        return address.trimmingCharacters(in: .whitespaces)
    }
}

/// Simulates an order service that confirms the order.
final class OrderService {
    func confirmOrder(cart: Cart, address: String, transactionId: String) async throws -> String {
        try await Task.sleep(for: .seconds(1))
        return "order_\(UUID().uuidString.prefix(8))"
    }
}

// MARK: - Supporting Types

enum PaymentMethod: String, CaseIterable {
    case applePay = "Apple Pay"
    case creditCard = "Credit Card"
}

struct Cart {
    var items: [CartItem] = [
        CartItem(name: "Pizza Supreme", price: 400),
        CartItem(name: "Garlic Bread", price: 200)
    ]
    var total: Double {
        items.reduce(0) { $0 + $1.price }
    }
}

struct CartItem: Identifiable {
    let id = UUID()
    let name: String
    let price: Double
}

enum CheckoutError: LocalizedError {
    case invalidAddress
    case paymentFailed
    case orderFailed

    var errorDescription: String? {
        switch self {
        case .invalidAddress: "Please enter a valid shipping address."
        case .paymentFailed: "Payment could not be processed."
        case .orderFailed: "We couldn't confirm your order."
        }
    }
}

// MARK: - Facade

/// The **Facade** provides a single, simple method to complete the entire
/// checkout process: validate address → process payment → confirm order.
final class PaymentFacade {
    private let paymentProcessor = PaymentProcessor()
    private let addressValidator = AddressValidator()
    private let orderService = OrderService()

    /// Execute the whole checkout workflow.
    /// - Parameters:
    ///   - cart: The user's cart.
    ///   - address: The raw shipping address.
    ///   - method: The chosen payment method.
    /// - Returns: The order confirmation ID.
    func checkout(cart: Cart, address: String, method: PaymentMethod) async throws -> String {
        let validatedAddress = try await addressValidator.validate(address)
        let transactionId = try await paymentProcessor.process(amount: cart.total, method: method)
        let orderId = try await orderService.confirmOrder(cart: cart, address: validatedAddress, transactionId: transactionId)
        return orderId
    }
}
