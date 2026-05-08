//
//  Pizza.swift
//  DesignPatternsInPractice
//
//  Created by Chetan purohit on 08/05/26.
//

import Foundation

struct Pizza: Equatable {
    let size: Size
    let toppings: [Topping]
    let crust: Crust
    
    enum Size: String, CaseIterable, CustomStringConvertible {
        case small = "Small"
        case medium = "Medium"
        case large = "Large"
        var description: String { rawValue }
    }
    enum Crust: String, CaseIterable, CustomStringConvertible {
        case thin = "Thin"
        case thick = "Thick"
        case glutenFree = "Gluten‑Free"
        var description: String { rawValue }
    }
    enum Topping: String, CaseIterable, Identifiable {
        case pepperoni = "Pepperoni"
        case mushrooms = "Mushrooms"
        case onions = "Onions"
        case olives = "Olives"
        case bacon = "Bacon"
        var id: String { rawValue }
    }
    var description: String {
        "\(size.description) \(crust.description) crust\nToppings: \(toppings.map(\.rawValue).joined(separator: ", "))"
    }
    var totalPrice: Double {
        let base: Double
        switch size {
        case .small: base = 100
        case .medium: base = 150
        case .large: base = 200
        }
        return base + Double(toppings.count) * 50
    }
}
