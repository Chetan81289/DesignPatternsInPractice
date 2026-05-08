//
//  ServiceProtocols.swift
//  DesignPatternsInPractice
//
//  Created by Chetan purohit on 08/05/26.
//

import Foundation
import UIKit

// MARK: - Payment
protocol PaymentServiceProtocol {
    func process(amount: Double, method: PaymentMethod) async throws -> String
}

// MARK: - Cart
protocol CartServiceProtocol {
    func fetchCart() async -> Cart
}

// MARK: - Image / Photo Enhancement
protocol ImageFilterServiceProtocol {
    func applyFilter(_ filter: ImageFilter, to image: UIImage) -> UIImage
}

// You can add more protocols as the app grows.
