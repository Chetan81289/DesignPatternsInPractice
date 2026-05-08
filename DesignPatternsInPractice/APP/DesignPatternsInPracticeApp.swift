//
//  DesignPatternsInPracticeApp.swift
//  DesignPatternsInPractice
//
//  Created by Chetan purohit on 07/05/26.
//

import SwiftUI

@main
struct DesignPatternsInPracticeApp: App {
    // The central dependency container – holds every service we may need
    let container = AppDIContainer()
    
    var body: some Scene {
        WindowGroup {
            // CoordinatorView takes ownership of the navigation
            AppCoordinator()
            // Inject the container into the environment so any view can access it
                .environmentObject(container)
            // Optional: apply the global theme (singleton) immediately
                .environment(\.theme, ThemeManager.shared.currentTheme)
        }
    }
}
