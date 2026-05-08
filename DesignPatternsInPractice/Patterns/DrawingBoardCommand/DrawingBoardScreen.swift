//
//  DrawingBoardScreen.swift
//  DesignPatternsInPractice
//
//  Created by Chetan purohit on 08/05/26.
//

import SwiftUI

struct DrawingBoardScreen: View {
    @StateObject private var canvasModel = DrawingCanvasModel()
    @State private var selectedColor: Color = .blue
    @State private var lineWidth: CGFloat = 3

    let colors: [Color] = [.blue, .red, .green, .black, .orange]

    var body: some View {
        VStack(spacing: 12) {
            // Canvas area
            DrawingCanvasView(
                model: canvasModel,
                currentColor: selectedColor,
                lineWidth: lineWidth
            )
            .frame(maxWidth: .infinity, maxHeight: 400)

            // Color picker
            HStack(spacing: 12) {
                ForEach(colors, id: \.self) { color in
                    Circle()
                        .fill(color)
                        .frame(width: 30, height: 30)
                        .overlay(
                            Circle().stroke(Color.white, lineWidth: selectedColor == color ? 4 : 0)
                        )
                        .shadow(radius: selectedColor == color ? 2 : 0)
                        .onTapGesture { selectedColor = color }
                }
            }

            // Undo / Redo / Clear
            HStack(spacing: 20) {
                Button(action: canvasModel.undo) {
                    Image(systemName: "arrow.uturn.backward")
                        .font(.title2)
                }
                .disabled(!canvasModel.canUndo)

                Button(action: canvasModel.redo) {
                    Image(systemName: "arrow.uturn.forward")
                        .font(.title2)
                }
                .disabled(!canvasModel.canRedo)

                Spacer()

                Button("Clear All") {
                    withAnimation { canvasModel.clear() }
                }
                .foregroundColor(.red)
            }
            .padding(.horizontal)
        }
        .padding()
        .navigationTitle("Drawing Board")
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
    }
}

