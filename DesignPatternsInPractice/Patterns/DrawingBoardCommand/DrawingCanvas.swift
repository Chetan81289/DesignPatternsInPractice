//
//  DrawingCanvas.swift
//  DesignPatternsInPractice
//
//  Created by Chetan purohit on 08/05/26.
//

import SwiftUI
import Combine


/// SwiftUI Canvas that renders strokes.
struct DrawingCanvasView: View {
    @ObservedObject var model: DrawingCanvasModel
    @State private var currentPoints: [CGPoint] = []
    @State private var isDrawing = false

    let currentColor: Color
    let lineWidth: CGFloat

    var body: some View {
        Canvas { context, size in
            // Draw completed strokes
            for stroke in model.strokes {
                var path = Path()
                if let first = stroke.points.first { path.move(to: first) }
                for point in stroke.points.dropFirst() { path.addLine(to: point) }
                context.stroke(path, with: .color(stroke.color), lineWidth: stroke.lineWidth)
            }
            // Draw current in‑progress stroke
            if !currentPoints.isEmpty {
                var path = Path()
                path.move(to: currentPoints[0])
                for point in currentPoints.dropFirst() { path.addLine(to: point) }
                context.stroke(path, with: .color(currentColor), lineWidth: lineWidth)
            }
        }
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { value in
                    if !isDrawing {
                        isDrawing = true
                        currentPoints = [value.location]
                    } else {
                        currentPoints.append(value.location)
                    }
                }
                .onEnded { _ in
                    if currentPoints.count > 1 {
                        model.addStroke(Stroke(points: currentPoints, color: currentColor, lineWidth: lineWidth))
                    }
                    currentPoints.removeAll()
                    isDrawing = false
                }
        )
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(radius: 4)
    }
}
