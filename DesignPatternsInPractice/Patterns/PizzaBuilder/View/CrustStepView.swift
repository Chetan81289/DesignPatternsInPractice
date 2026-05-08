//
//  CrustStepView.swift
//  DesignPatternsInPractice
//
//  Created by Chetan purohit on 08/05/26.
//

import SwiftUI
import Combine


// MARK: - Step 2: Crust Selection

struct CrustStepView: View {
    @Binding var selectedCrust: Pizza.Crust
    let action: () -> Void

    var body: some View {
        VStack(spacing: 24) {
            Text("Choose Crust")
                .font(.title2.bold())

            ForEach(Pizza.Crust.allCases, id: \.self) { crust in
                Button {
                    withAnimation(.easeInOut) { selectedCrust = crust }
                } label: {
                    HStack {
                        Text(crust.description)
                            .font(.headline)
                        Spacer()
                        if selectedCrust == crust {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.orange)
                        }
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(selectedCrust == crust ? Color.orange.opacity(0.15) : Color(.systemBackground))
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(selectedCrust == crust ? Color.orange : Color.clear, lineWidth: 2)
                    )
                }
                .buttonStyle(.plain)
            }

            HStack {
                Button("Back") {
                    withAnimation { /* handled by view model navigation */ }
                }
                .buttonStyle(.bordered)

                Spacer()

                Button(action: action) {
                    Text("Next")
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

