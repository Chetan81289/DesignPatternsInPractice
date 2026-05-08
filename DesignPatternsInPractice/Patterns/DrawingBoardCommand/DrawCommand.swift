//
//  DrawCommand.swift
//  DesignPatternsInPractice
//
//  Created by Chetan purohit on 08/05/26.
//

import SwiftUI

/// The Command protocol – all drawing actions conform to this.
protocol DrawCommand {
    func execute()
    func undo()
}

/// A single stroke on the canvas.
struct Stroke {
    let points: [CGPoint]
    let color: Color
    let lineWidth: CGFloat
}

/// Concrete Command that adds a stroke to the canvas.
struct AddStrokeCommand: DrawCommand {
    private let stroke: Stroke
    private unowned let canvas: DrawingCanvasModel

    init(stroke: Stroke, canvas: DrawingCanvasModel) {
        self.stroke = stroke
        self.canvas = canvas
    }

    func execute() {
        canvas.addStrokeDirectly(stroke)
    }

    func undo() {
        canvas.removeLastStrokeDirectly()
    }
}
