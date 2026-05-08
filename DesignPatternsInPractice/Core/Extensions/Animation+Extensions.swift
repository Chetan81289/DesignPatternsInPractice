//
//  Animation+Extensions.swift
//  DesignPatternsInPractice
//
//  Created by Chetan purohit on 08/05/26.
//

import SwiftUI

extension View {
    /// Applies a shaking animation (e.g., for invalid input).
    func shake(count: Int = 3, amplitude: CGFloat = 6) -> some View {
        withAnimation(.default) { self } // placeholder, real shake uses a modifier.
        // For a working version, we'll use a custom ViewModifier.
        return self.modifier(ShakeEffect(shakes: count, amplitude: amplitude))
    }

    /// Applies a pulsing scale animation (useful for highlighting a button).
    func pulse() -> some View {
        self.modifier(PulseEffect())
    }

    /// Smooth transition that fades and scales.
    func smoothTransition() -> some View {
        self.transition(.asymmetric(
            insertion: .opacity.combined(with: .scale(scale: 0.95)),
            removal: .opacity.combined(with: .scale(scale: 0.95))
        ))
    }
}

// MARK: - Shake Effect

struct ShakeEffect: ViewModifier {
    let shakes: Int
    let amplitude: CGFloat

    func body(content: Content) -> some View {
        content
            .modifier(ShakeAnimatable(shakes: shakes, amplitude: amplitude))
    }
}

struct ShakeAnimatable: GeometryEffect {
    var shakes: Int
    var amplitude: CGFloat
    var animatableData: CGFloat = 0

    func effectValue(size: CGSize) -> ProjectionTransform {
        let xOffset = sin(animatableData * .pi * CGFloat(shakes)) * amplitude
        return ProjectionTransform(CGAffineTransform(translationX: xOffset, y: 0))
    }
}

extension View {
    func shakeEffect(shakes: Int, amplitude: CGFloat) -> some View {
        self.modifier(ShakeEffect(shakes: shakes, amplitude: amplitude))
    }
}

// MARK: - Pulse Effect

struct PulseEffect: ViewModifier {
    @State private var isPulsing = false

    func body(content: Content) -> some View {
        content
            .scaleEffect(isPulsing ? 1.05 : 1.0)
            .animation(.easeInOut(duration: 0.8).repeatForever(autoreverses: true), value: isPulsing)
            .onAppear { isPulsing = true }
    }
}
