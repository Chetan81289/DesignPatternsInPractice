//
//  PizzaBuilder.swift
//  DesignPatternsInPractice
//
//  Created by Chetan purohit on 08/05/26.
//

import Foundation

/// Builds a `Pizza` step‑by‑step, following the Builder design pattern.
/// All setter methods return `Self` to allow method chaining.

final class PizzaBuilder {
    var size: Pizza.Size = .medium
    var crust: Pizza.Crust = .thin
    var toppings: Set<Pizza.Topping> = []
    
    @discardableResult
    func setSize(_ size: Pizza.Size) -> Self {
        self.size = size
        return self
    }
    
    @discardableResult
    func setCrust(_ crust: Pizza.Crust) -> Self {
        self.crust = crust
        return self
    }
    
    @discardableResult
    func addTopping(_ topping: Pizza.Topping) -> Self {
        toppings.insert(topping)
        return self
    }
    
    @discardableResult
    func removeTopping(_ topping: Pizza.Topping) -> Self {
        toppings.remove(topping)
        return self
    }
    func build() -> Pizza {
        Pizza(
            size: size,
            toppings: Array(toppings),
            crust: crust
        )
    }
    var summary: String {
        build().description
    }
    
    var price: Double {
        build().totalPrice
    }
}
