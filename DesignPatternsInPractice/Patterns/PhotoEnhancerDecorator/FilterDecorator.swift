//
//  FilterDecorator.swift
//  DesignPatternsInPractice
//
//  Created by Chetan purohit on 08/05/26.
//

import SwiftUI
import Combine

final class PhotoDecorator: ObservableObject {
    private let base: UIImage
    @Published private(set) var activeFilters: [ImageFilter] = []
    @Published private(set) var renderedImage: Image

    init(imageName: String = "sample") {
        self.base = UIImage(named: imageName) ?? UIImage()
        self.renderedImage = Image(uiImage: base)
    }

    func addFilter(_ filter: ImageFilter) {
        activeFilters.append(filter)
        update()
    }

    func removeFilter(at index: Int) {
        guard activeFilters.indices.contains(index) else { return }
        activeFilters.remove(at: index)
        update()
    }

    private func update() {
        var img = base
        for filter in activeFilters {
            img = filter.apply(to: img)
        }
        renderedImage = Image(uiImage: img)
    }
}
