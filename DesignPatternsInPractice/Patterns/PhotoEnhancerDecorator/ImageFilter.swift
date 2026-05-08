//
//  ImageFilter.swift
//  DesignPatternsInPractice
//
//  Created by Chetan purohit on 08/05/26.
//

import SwiftUI
import Combine
import UIKit

protocol ImageFilter {
    var name: String { get }
    func apply(to image: UIImage) -> UIImage
}

struct SepiaFilter: ImageFilter {
    var name: String { "Sepia" }
    func apply(to image: UIImage) -> UIImage {
        guard let ciImage = CIImage(image: image) else { return image }
        let filter = CIFilter(name: "CISepiaTone")!
        filter.setValue(ciImage, forKey: kCIInputImageKey)
        filter.setValue(0.8, forKey: "inputIntensity")
        let context = CIContext()
        if let output = filter.outputImage,
           let cgImage = context.createCGImage(output, from: output.extent) {
            return UIImage(cgImage: cgImage)
        }
        return image
    }
}

struct BlurFilter: ImageFilter {
    var name: String { "Blur" }
    func apply(to image: UIImage) -> UIImage {
        guard let ciImage = CIImage(image: image) else { return image }
        let filter = CIFilter(name: "CIGaussianBlur")!
        filter.setValue(ciImage, forKey: kCIInputImageKey)
        filter.setValue(5.0, forKey: "inputRadius")
        let context = CIContext()
        if let output = filter.outputImage,
           let cgImage = context.createCGImage(output, from: output.extent) {
            return UIImage(cgImage: cgImage)
        }
        return image
    }
}

struct VignetteFilter: ImageFilter {
    var name: String { "Vignette" }
    func apply(to image: UIImage) -> UIImage {
        guard let ciImage = CIImage(image: image) else { return image }
        let filter = CIFilter(name: "CIVignette")!
        filter.setValue(ciImage, forKey: kCIInputImageKey)
        filter.setValue(2.0, forKey: "inputIntensity")
        filter.setValue(30.0, forKey: "inputRadius")
        let context = CIContext()
        if let output = filter.outputImage,
           let cgImage = context.createCGImage(output, from: output.extent) {
            return UIImage(cgImage: cgImage)
        }
        return image
    }
}
