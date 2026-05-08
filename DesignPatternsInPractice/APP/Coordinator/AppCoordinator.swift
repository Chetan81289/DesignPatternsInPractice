//
//  AppCoordinator.swift
//  DesignPatternsInPractice
//
//  Created by Chetan purohit on 07/05/26.
//

import SwiftUI
import Combine

/// The main coordinator – it owns the navigation stack and builds the root tab view.

struct AppCoordinator: View {
    @StateObject private var navigation = NavigationManager()

    var body: some View {
        TabView {
            // Tab 1: Home – contains pattern showcase
            NavigationStack(path: $navigation.path) {
                HomeScreen()
                    .navigationDestination(for: Route.self) { route in
                        destinationView(for: route)
                    }
            }
            .tabItem { Label("Patterns", systemImage: "rectangle.grid.2x2") }
            .environmentObject(navigation)

            // Tab 2: Settings
            SettingsScreen()
                .tabItem { Label("Settings", systemImage: "gearshape") }
        }
    }

    @ViewBuilder
    private func destinationView(for route: Route) -> some View {
        switch route {
        case .productList:
            ProductListScreen()
        case .pizzaBuilder:
            PizzaBuilderScreen()
        case .photoEnhancer:
            PhotoEnhancerScreen()
        case .checkout:
            CheckoutScreen()
        case .drawingBoard:
            DrawingBoardScreen()
        case .supportTickets:
            SupportTicketsScreen()
        case .settings:
            SettingsScreen()
        case .productDetail(let id):
            ProductDetailScreen(productId: id)
        case .orderConfirmation(let orderId):
            OrderConfirmationScreen(orderId: orderId)
        }
    }
}

/// Navigation controller accessible from any child view via `@EnvironmentObject`.
final class NavigationManager: ObservableObject {
    @Published var path = NavigationPath()

    func push(_ route: Route) { path.append(route) }
    func pop() { path.removeLast() }
    func popToRoot() { path = NavigationPath() }
}

// Dummy screens for the ones we haven't built yet
struct ProductListScreen: View { var body: some View { Text("Product List Screen") } }
struct ProductDetailScreen: View { let productId: String; var body: some View { Text("Product: \(productId)") } }
struct OrderConfirmationScreen: View { let orderId: String; var body: some View { Text("Order: \(orderId)") } }
struct DrawingBoardScreen: View { var body: some View { Text("Drawing Board Screen") } }
struct SupportTicketsScreen: View { var body: some View { Text("Support Tickets Screen") } }
struct SettingsScreen: View {
    // Will use ThemeManager singleton later
    var body: some View { Text("Settings") }
}

struct PhotoEnhancerScreen: View {
    var body: some View { Text("PhotoEnhancerScreen") }
}
struct CheckoutScreen: View {
    var body: some View { Text("CheckoutScreen") }
}

