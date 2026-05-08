//
//  HomeScreen.swift
//  DesignPatternsInPractice
//
//  Created by Chetan purohit on 07/05/26.
//

import SwiftUI
import Combine

// A simple HomeScreen that lists patterns (menu)
struct HomeScreen: View {
    @EnvironmentObject var navigation: NavigationManager

    var body: some View {
        List {
            NavigationLink(value: Route.pizzaBuilder) {
                Label("Pizza Builder (Builder)", systemImage: "fork.knife")
            }
            NavigationLink(value: Route.photoEnhancer) {
                Label("Photo Enhancer (Decorator)", systemImage: "camera.filters")
            }
            NavigationLink(value: Route.checkout) {
                Label("Checkout (Facade)", systemImage: "cart")
            }
            NavigationLink(value: Route.productList) {
                Label("Product List (Strategy)", systemImage: "list.bullet")
            }
            NavigationLink(value: Route.drawingBoard) {
                Label("Drawing Board (Command)", systemImage: "pencil.tip")
            }
            NavigationLink(value: Route.supportTickets) {
                Label("Support Tickets (Chain of Resp.)", systemImage: "ticket")
            }
        }
        .navigationTitle("Patterns in Practice")
    }
}
