//
//  DrawingCanvasModel.swift
//  DesignPatternsInPractice
//
//  Created by Chetan purohit on 08/05/26.
//

import SwiftUI
import Combine

/// The data model for the drawing canvas – holds strokes and command history.
final class DrawingCanvasModel: ObservableObject {
    @Published private(set) var strokes: [Stroke] = []
    private var undoStack: [DrawCommand] = []
    private var redoStack: [DrawCommand] = []

    var canUndo: Bool { !undoStack.isEmpty }
    var canRedo: Bool { !redoStack.isEmpty }

    // Called by the command to directly modify the strokes array
    func addStrokeDirectly(_ stroke: Stroke) {
        strokes.append(stroke)
    }

    func removeLastStrokeDirectly() {
        guard !strokes.isEmpty else { return }
        strokes.removeLast()
    }

    /// Public method: user finishes a stroke → create command and execute.
    func addStroke(_ stroke: Stroke) {
        let command = AddStrokeCommand(stroke: stroke, canvas: self)
        command.execute()
        undoStack.append(command)
        redoStack.removeAll() // new action clears redo
    }

    /// Undo the last stroke.
    func undo() {
        guard let command = undoStack.popLast() else { return }
        command.undo()
        redoStack.append(command)
    }

    /// Redo the last undone stroke.
    func redo() {
        guard let command = redoStack.popLast() else { return }
        command.execute()
        undoStack.append(command)
    }

    /// Clear all strokes and history.
    func clear() {
        strokes.removeAll()
        undoStack.removeAll()
        redoStack.removeAll()
    }
}

