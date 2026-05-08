//
//  ProductListViewModel.swift
//  DesignPatternsInPractice
//
//  Created by Chetan purohit on 08/05/26.
//

import SwiftUI
import Combine

enum SortOption: String, CaseIterable {
    case name = "Name"
    case priceAscending = "Price ↑"
    case priceDescending = "Price ↓"

    var strategy: SortingStrategy {
        switch self {
        case .name: return SortByName()
        case .priceAscending: return SortByPriceAscending()
        case .priceDescending: return SortByPriceDescending()
        }
    }
}

@MainActor
final class ProductListViewModel: ObservableObject {
    // Sample data – in a real app this would come from a service
    private let allProducts: [Product] = [
        Product(name: "iPhone 15", price: 999, category: "Phones"),
        Product(name: "MacBook Air", price: 1099, category: "Computers"),
        Product(name: "AirPods Pro", price: 249, category: "Audio"),
        Product(name: "iPad Pro", price: 799, category: "Tablets"),
        Product(name: "Watch Ultra", price: 799, category: "Wearables"),
        Product(name: "Vision Pro", price: 3499, category: "Spatial"),
    ]

    @Published var selectedSort: SortOption = .name {
        didSet { applySort() }
    }
    @Published private(set) var products: [Product] = []

    init() {
        applySort()
    }

    private func applySort() {
        let strategy = selectedSort.strategy
        withAnimation(.easeInOut) {
            products = strategy.sort(allProducts)
        }
    }
}
