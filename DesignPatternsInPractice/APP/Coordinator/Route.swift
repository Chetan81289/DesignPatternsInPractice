//
//  Route.swift
//  DesignPatternsInPractice
//
//  Created by Chetan purohit on 07/05/26.
//

import SwiftUI

/// All navigation destinations in the app.
/// Using an enum with associated values allows type‑safe deep linking.

enum Route: Hashable, Equatable {
    // Pattern screens
    case productList
    case pizzaBuilder
    case photoEnhancer
    case checkout
    case drawingBoard
    case supportTickets
    case settings

    // Additional screens
    case productDetail(productId: String)
    case orderConfirmation(orderId: String)
}
