//
//  CheckoutScreen.swift
//  DesignPatternsInPractice
//
//  Created by Chetan purohit on 08/05/26.
//

import SwiftUI

struct CheckoutScreen: View {
    @StateObject private var viewModel = CheckoutViewModel()

    var body: some View {
        VStack(spacing: 0) {
            // Form content
            Form {
                // MARK: - Address Section
                Section("Shipping Address") {
                    TextField("123 Main Street", text: $viewModel.address)
                        .textContentType(.fullStreetAddress)
                        .disabled(viewModel.isProcessing || viewModel.orderId != nil)
                }

                // MARK: - Payment Method
                Section("Payment Method") {
                    Picker("Method", selection: $viewModel.selectedPaymentMethod) {
                        ForEach(PaymentMethod.allCases, id: \.self) { method in
                            Text(method.rawValue).tag(method)
                        }
                    }
                    .pickerStyle(.segmented)
                    .disabled(viewModel.isProcessing || viewModel.orderId != nil)
                }

                // MARK: - Cart Summary
                Section("Your Order") {
                    ForEach(viewModel.cart.items) { item in
                        HStack {
                            Text(item.name)
                            Spacer()
                            Text("\(item.price, specifier: "%.2f")")
                                .foregroundColor(.secondary)
                        }
                    }
                    HStack {
                        Text("Total")
                            .fontWeight(.bold)
                        Spacer()
                        Text("\(viewModel.cart.total, specifier: "%.2f")")
                            .fontWeight(.bold)
                    }
                }

                // MARK: - Place Order Button
                Section {
                    Button(action: viewModel.placeOrder) {
                        HStack {
                            Spacer()
                            if viewModel.isProcessing {
                                ProgressView()
                                    .tint(.white)
                            } else if let orderId = viewModel.orderId {
                                Label("Order Confirmed", systemImage: "checkmark.circle.fill")
                                    .foregroundColor(.white)
                            } else {
                                Text("Place Order")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                            }
                            Spacer()
                        }
                        .padding(.vertical, 8)
                        .frame(maxWidth: .infinity)
                        .background(buttonBackground)
                        .cornerRadius(10)
                    }
                    .disabled(!viewModel.canPlaceOrder)
                }

                // MARK: - Order ID Display
                if let orderId = viewModel.orderId {
                    Section {
                        HStack {
                            Image(systemName: "checkmark.seal.fill")
                                .foregroundColor(.green)
                            Text("Order ID: \(orderId)")
                                .font(.caption.monospaced())
                        }
                    }
                }
            }
        }
        .navigationTitle("Checkout")
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
        .alert("Checkout Error", isPresented: Binding<Bool>(
            get: { viewModel.errorMessage != nil },
            set: { if !$0 { viewModel.errorMessage = nil } }
        )) {
            Button("OK") { viewModel.errorMessage = nil }
        } message: {
            Text(viewModel.errorMessage ?? "")
        }
        .onDisappear {
            // Reset for next time the screen appears (optional)
            if viewModel.orderId != nil {
                viewModel.reset()
            }
        }
    }

    // Dynamic button background color
    @ViewBuilder
    private var buttonBackground: some View {
        if viewModel.orderId != nil {
            Color.green
        } else if viewModel.isProcessing {
            Color.gray
        } else {
            Color.blue
        }
    }
}

