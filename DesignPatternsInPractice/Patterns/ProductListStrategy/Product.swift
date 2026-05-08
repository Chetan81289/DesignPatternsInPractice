//
//  Product.swift
//  DesignPatternsInPractice
//
//  Created by Chetan purohit on 08/05/26.
//

import Foundation

struct Product: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let price: Double
    let category: String
}
