//
//  ThemeManager.swift
//  DesignPatternsInPractice
//
//  Created by Chetan purohit on 08/05/26.
//


import Combine
import SwiftUI

// MARK: - App Theme Model

struct AppTheme: Equatable {
    var primaryColor: Color
    var backgroundColor: Color
    var textColor: Color
    var font: Font

    static let light = AppTheme(
        primaryColor: .orange,
        backgroundColor: Color(.systemGroupedBackground),
        textColor: .primary,
        font: .body
    )

    static let dark = AppTheme(
        primaryColor: .orange,
        backgroundColor: Color(red: 28/255, green: 28/255, blue: 30/255),  // #1C1C1E
        textColor: .black,
        font: .body
    )
}

// MARK: - Theme Manager (Singleton)

final class ThemeManager: ObservableObject {
    /// Shared instance – the Singleton.
    static let shared = ThemeManager()

    @Published var currentTheme: AppTheme = .light

    private init() {}  // Prevent external instantiation

    func toggleTheme() {
        withAnimation(.easeInOut(duration: 0.3)) {
            currentTheme = (currentTheme == .light) ? .dark : .light
        }
    }
}

// MARK: - SwiftUI Environment Key

struct ThemeKey: EnvironmentKey {
    static let defaultValue: AppTheme = .light
}

extension EnvironmentValues {
    var theme: AppTheme {
        get { self[ThemeKey.self] }
        set { self[ThemeKey.self] = newValue }
    }
}

