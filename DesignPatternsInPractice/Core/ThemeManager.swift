//
//  ThemeManager.swift
//  DesignPatternsInPractice
//
//  Created by Chetan purohit on 08/05/26.
//

import SwiftUI
import Combine

struct AppTheme {
    var primaryColor: Color = .orange
    var backgroundColor: Color = Color(.systemGroupedBackground)
    var font: Font = .body
}

final class ThemeManager: ObservableObject {
    static let shared = ThemeManager()
    private init() {}
    @Published var currentTheme = AppTheme()
}

// SwiftUI environment key for theme
struct ThemeKey: EnvironmentKey {
    static let defaultValue: AppTheme = AppTheme()
}

extension EnvironmentValues {
    var theme: AppTheme {
        get { self[ThemeKey.self] }
        set { self[ThemeKey.self] = newValue }
    }
}

