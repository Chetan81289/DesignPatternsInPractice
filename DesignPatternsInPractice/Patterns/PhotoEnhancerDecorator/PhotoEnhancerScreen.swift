//
//  PhotoEnhancerScreen.swift
//  DesignPatternsInPractice
//
//  Created by Chetan purohit on 08/05/26.
//

import SwiftUI
import Combine

/// The Decorator that wraps a base image and applies a chain of filters.
/// It maintains a list of filters and exposes a combined rendered image.

struct PhotoEnhancerScreen: View {
    @StateObject private var decorator = PhotoDecorator()
    private let availableFilters: [ImageFilter] = [
        SepiaFilter(),
        BlurFilter(),
        VignetteFilter()
    ]

    var body: some View {
        VStack(spacing: 0) {
            decorator.renderedImage
                .resizable()
                .scaledToFit()
                .frame(height: 300)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(radius: 8)
                .padding()

            List {
                Section("Active Filters") {
                    if decorator.activeFilters.isEmpty {
                        Text("No filters applied yet")
                            .foregroundColor(.secondary)
                    } else {
                        ForEach(Array(decorator.activeFilters.enumerated()), id: \.offset) { index, filter in
                            HStack {
                                Text(filter.name)
                                Spacer()
                                Button("Remove") {
                                    withAnimation {
                                        decorator.removeFilter(at: index)
                                    }
                                }
                                .foregroundColor(.red)
                            }
                        }
                    }
                }

                Section("Add a Filter") {
                    ForEach(availableFilters, id: \.name) { filter in
                        Button {
                            withAnimation {
                                decorator.addFilter(filter)
                            }
                        } label: {
                            HStack {
                                Text(filter.name)
                                Spacer()
                                Image(systemName: "plus.circle")
                                    .foregroundColor(.orange)
                            }
                        }
                    }
                }
            }
            .listStyle(.insetGrouped)
        }
        .navigationTitle("Photo Enhancer")
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
    }
}
