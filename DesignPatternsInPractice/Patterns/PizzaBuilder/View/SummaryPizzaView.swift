//
//  SummaryPizzaView.swift
//  DesignPatternsInPractice
//
//  Created by Chetan purohit on 08/05/26.
//

import SwiftUI
import Combine

// MARK: - Step 4: Summary

struct SummaryPizzaView: View {
    let pizza: Pizza
    let resetAction: () -> Void

    var body: some View {
        VStack(spacing: 24) {
            Image(systemName: "fork.knife")
                .font(.system(size: 60))
                .foregroundColor(.orange)
                .padding()

            Text("Your Custom Pizza 🍕")
                .font(.title.bold())

            Text(pizza.description)
                .font(.body)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(.systemBackground))
                )

            Text("Total: $\(pizza.totalPrice, specifier: "%.2f")")
                .font(.title2.bold())

            Button(action: resetAction) {
                Text("Build Another")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            .padding(.top, 20)

            Spacer()
        }
        .padding(.horizontal, 30)
    }
}
