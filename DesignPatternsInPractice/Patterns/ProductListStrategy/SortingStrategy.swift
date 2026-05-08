//
//  SortingStrategy.swift
//  DesignPatternsInPractice
//
//  Created by Chetan purohit on 08/05/26.
//

import Foundation

/// The Strategy protocol – all sorting algorithms conform to this.
protocol SortingStrategy {
    func sort(_ products: [Product]) -> [Product]
}

// Concrete strategies

struct SortByName: SortingStrategy {
    func sort(_ products: [Product]) -> [Product] {
        products.sorted { $0.name.lowercased() < $1.name.lowercased() }
    }
}

struct SortByPriceAscending: SortingStrategy {
    func sort(_ products: [Product]) -> [Product] {
        products.sorted { $0.price < $1.price }
    }
}

struct SortByPriceDescending: SortingStrategy {
    func sort(_ products: [Product]) -> [Product] {
        products.sorted { $0.price > $1.price }
    }
}
