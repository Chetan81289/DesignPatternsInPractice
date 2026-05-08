//
//  SizeStepView.swift
//  DesignPatternsInPractice
//
//  Created by Chetan purohit on 08/05/26.
//

import SwiftUI
import Combine

// MARK: - Step 1: Size Selection

struct SizeStepView: View {
    @Binding var selectedSize: Pizza.Size
    let action: () -> Void

    var body: some View {
        VStack(spacing: 24) {
            Text("Choose Size")
                .font(.title2.bold())

            ForEach(Pizza.Size.allCases, id: \.self) { size in
                Button {
                    withAnimation(.easeInOut) { selectedSize = size }
                } label: {
                    HStack {
                        Text(size.description)
                            .font(.headline)
                        Spacer()
                        if selectedSize == size {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.orange)
                        }
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(selectedSize == size ? Color.orange.opacity(0.15) : Color(.systemBackground))
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(selectedSize == size ? Color.orange : Color.clear, lineWidth: 2)
                    )
                }
                .buttonStyle(.plain)
            }

            Button(action: action) {
                Text("Next")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            .padding(.top, 16)
        }
        .padding(.horizontal, 30)
    }
}
