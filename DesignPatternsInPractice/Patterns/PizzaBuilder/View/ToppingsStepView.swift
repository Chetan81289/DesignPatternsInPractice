//
//  ToppingsStepView.swift
//  DesignPatternsInPractice
//
//  Created by Chetan purohit on 08/05/26.
//

import SwiftUI
import Combine

// MARK: - Step 3: Toppings Selection

struct ToppingsStepView: View {
    @Binding var selectedToppings: Set<Pizza.Topping>
    let builder: PizzaBuilder
    let action: () -> Void

    var body: some View {
        VStack(spacing: 24) {
            Text("Add Toppings")
                .font(.title2.bold())

            ForEach(Pizza.Topping.allCases) { topping in
                HStack {
                    Text(topping.rawValue)
                        .font(.headline)
                    Spacer()
                    Text("+50")
                        .foregroundColor(.secondary)
                    Toggle("", isOn: Binding(
                        get: { selectedToppings.contains(topping) },
                        set: { isSelected in
                            if isSelected {
                                builder.addTopping(topping)
                               // builder.price += 50
                            } else {
                                builder.removeTopping(topping)
                                //builder.price += 50
                            }
                        }
                    ))
                    .toggleStyle(.switch)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(.systemBackground))
                )
            }

            Text("Current price: \(builder.price, specifier: "%.2f")")
                .font(.headline)

            HStack {
                Button("Back") {
                    withAnimation { /* handled by view model navigation */ }
                }
                .buttonStyle(.bordered)

                Spacer()

                Button(action: action) {
                    Text("Finish")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
            }
            .padding(.top, 16)
        }
        .padding(.horizontal, 30)
    }
}
