//
//  CheckoutViewModel.swift
//  DesignPatternsInPractice
//
//  Created by Chetan purohit on 08/05/26.
//

import SwiftUI
import Combine

@MainActor
final class CheckoutViewModel: ObservableObject {
    // MARK: Input
    @Published var address = "123 Main St"
    @Published var selectedPaymentMethod: PaymentMethod = .applePay

    // MARK: Output
    @Published var isProcessing = false
    @Published var orderId: String?          // nil until order is confirmed
    @Published var errorMessage: String?     // displayed as alert

    let cart = Cart()
    private let facade = PaymentFacade()

    var canPlaceOrder: Bool {
        !address.trimmingCharacters(in: .whitespaces).isEmpty && !isProcessing
    }

    func placeOrder() {
        guard canPlaceOrder else { return }

        isProcessing = true
        errorMessage = nil
        orderId = nil

        Task {
            do {
                let result = try await facade.checkout(
                    cart: cart,
                    address: address,
                    method: selectedPaymentMethod
                )
                orderId = result
            } catch {
                errorMessage = (error as? CheckoutError)?.errorDescription ?? error.localizedDescription
            }
            isProcessing = false
        }
    }

    func reset() {
        address = ""
        selectedPaymentMethod = .applePay
        orderId = nil
        errorMessage = nil
    }
}
