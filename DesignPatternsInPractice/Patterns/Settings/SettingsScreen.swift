//
//  SettingsScreen.swift
//  DesignPatternsInPractice
//
//  Created by Chetan purohit on 08/05/26.
//

import SwiftUI
import Combine

struct SettingsScreen: View {
    // Observe the shared Singleton directly
    @ObservedObject private var themeManager = ThemeManager.shared

    @State private var showClearCacheAlert = false
    @State private var showCacheClearedConfirmation = false

    var body: some View {
        Form {
            // MARK: - Theme Section
            Section("Appearance") {
                HStack {
                    Image(systemName: "moon.circle.fill")
                            .foregroundColor(themeManager.currentTheme.primaryColor)
                        Text("Dark Mode")
                            .foregroundColor(themeManager.currentTheme.textColor)
                    Spacer()
                    Text(themeManager.currentTheme == .light ? "Light" : "Dark")
                        .foregroundColor(.secondary)
                }

                Toggle(isOn: Binding<Bool>(
                    get: { themeManager.currentTheme == .dark },
                    set: { _ in themeManager.toggleTheme() }
                )) {
                    Label("Dark Mode", systemImage: "moon.circle.fill")
                        .foregroundColor(themeManager.currentTheme.textColor)
                }

                // Colour preview circle
                HStack {
                    Text("Accent Colour")
                    Spacer()
                    Circle()
                        .fill(themeManager.currentTheme.primaryColor)
                        .frame(width: 24, height: 24)
                }
            }

            // MARK: - Cache Section
            Section("Data") {
                Button("Clear Cache") {
                    showClearCacheAlert = true
                }
                .foregroundColor(.red)
                .alert("Clear Cache", isPresented: $showClearCacheAlert) {
                    Button("Cancel", role: .cancel) { }
                    Button("Clear", role: .destructive) {
                        // Simulate cache clearing
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            showCacheClearedConfirmation = true
                        }
                    }
                } message: {
                    Text("This will remove all cached data and cannot be undone.")
                }

                if showCacheClearedConfirmation {
                    HStack {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                        Text("Cache cleared successfully")
                            .font(.caption)
                    }
                }
            }

            // MARK: - About Section
            Section("About") {
                HStack {
                    Text("App Version")
                    Spacer()
                    Text("1.0.0")
                        .foregroundColor(.secondary)
                }
                HStack {
                    Text("Design Patterns in Practice")
                    Spacer()
                    Text("Chetan Purohit")
                        .foregroundColor(.secondary)
                }
            }
        }
        .navigationTitle("Settings")
        .background(themeManager.currentTheme.backgroundColor.ignoresSafeArea())
        // Use the theme’s background and text color for the entire form
        .scrollContentBackground(.hidden)
        .tint(themeManager.currentTheme.primaryColor)
    }
}

struct SettingsScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SettingsScreen()
        }
    }
}
