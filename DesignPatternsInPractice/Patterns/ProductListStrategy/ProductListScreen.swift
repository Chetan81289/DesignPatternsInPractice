//
//  ProductListScreen.swift
//  DesignPatternsInPractice
//
//  Created by Chetan purohit on 08/05/26.
//

import SwiftUI
import Combine

struct ProductListScreen: View {
    @StateObject private var viewModel = ProductListViewModel()

    var body: some View {
        VStack(spacing: 0) {
            // Strategy picker
            Picker("Sort by", selection: $viewModel.selectedSort) {
                ForEach(SortOption.allCases, id: \.self) { option in
                    Text(option.rawValue).tag(option)
                }
            }
            .pickerStyle(.segmented)
            .padding()

            // Product list
            List(viewModel.products) { product in
                HStack {
                    VStack(alignment: .leading) {
                        Text(product.name)
                            .font(.headline)
                        Text(product.category)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                    Text("$\(product.price, specifier: "%.2f")")
                        .font(.title3.monospaced())
                        .foregroundColor(.orange)
                }
                .padding(.vertical, 4)
            }
            .listStyle(.insetGrouped)
        }
        .navigationTitle("Product List")
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
    }
}

struct ProductListScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ProductListScreen()
        }
    }
}
