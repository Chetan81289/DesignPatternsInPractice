# Design Patterns in Practice

<p align="center">
  <img src="https://img.shields.io/badge/Swift-6.0-orange" alt="Swift 6">
  <img src="https://img.shields.io/badge/iOS-17.0+-blue" alt="iOS 17+">
  <img src="https://img.shields.io/badge/Xcode-16.0+-blueviolet" alt="Xcode 16+">
  <img src="https://img.shields.io/badge/Architecture-MVVM%20%2B%20Coordinator-success" alt="Architecture">
  <img src="https://img.shields.io/badge/Patterns-9%2B-ff69b4" alt="Patterns">
</p>

A **production‑grade iOS app** that demonstrates essential design patterns through **real‑world, interactive scenarios** – not abstract toy examples.  
Every screen is a standalone module with polished SwiftUI UI, animations, and clear separation of concerns. Built to show that you understand *why* and *when* to use a pattern, not just *what* it is.

> Perfect for freelancers who want to prove their architectural skills with code clients can actually run and understand.

---

## 📱 Patterns Covered

| Pattern | Real‑World Scenario | Screen |
|---------|---------------------|--------|
| **Strategy** | Sorting products by name, price ascending/descending | Product List |
| **Builder** | Step‑by‑step custom pizza creation with live summary | Custom Pizza |
| **Decorator** | Applying/removing photo filters (sepia, blur, vignette) dynamically | Photo Enhancer |
| **Facade** | Simplified checkout process hiding payment, validation, and order services | Checkout |
| **Command** | Drawing board with undo/redo – each stroke is a command object | Drawing Board |
| **Chain of Responsibility** | Support ticket routing: Basic → Premium → Manager | Support Tickets |
| **Singleton** | Global theme manager toggles light/dark mode across the entire app | Settings |
| **Factory** | Creating different payment processors (Apple Pay / Credit Card) – integrated into Checkout | (Checkout) |
| **Observer** | Real‑time order status updates via Combine publishers | (Live Order Tracker) |
| **Delegation** | Custom image picker with cancel/confirm delegates | (Image Picker) |
| **Coordinator** | Type‑safe navigation, deep linking, decoupled views | App Coordinator |
| **Dependency Injection** | Swappable services via container, enabling testing and modularity | App Container |

---

## 🧱 Architecture
```
┌─────────────────────────┐
│ Coordinator │ Manages navigation & deep linking
└──────────┬──────────────┘
│ pushes screens
┌──────────▼──────────────┐
│ Screen (SwiftUI View) │ Displays UI, owned by a ViewModel
└──────────┬──────────────┘
│ observes
┌──────────▼──────────────┐
│ ViewModel │ Holds state, handles business logic
└──────────┬──────────────┘
│ uses
┌──────────▼──────────────┐
│ Service / Pattern │ Strategy, Builder, Facade, etc.
└──────────────────────────┘
```

- **Coordinator** decouples navigation from views.
- **Dependency Injection** makes every component testable and swappable.
- **MVVM** keeps UI logic clean and separate from the view.
- **Protocols** everywhere – services, strategies, handlers – enable mocking and unit testing.

---

## 🛠 Tech Stack

| Layer            | Technology |
|------------------|------------|
| UI               | SwiftUI |
| State Management | Combine, @Published, @StateObject |
| Navigation       | Custom Coordinator with `NavigationStack` |
| Persistence      | None (patterns are purely logic‑focused) |
| Testing          | Easily testable thanks to protocols & DI |
| Minimum Target   | iOS 17.0 |
| Language         | Swift 6 |

---

## 📂 Project Structure
```
PatternsInPractice/
├── App/
│   ├── PatternsInPracticeApp.swift         # @main, DI setup, Coordinator entry
│   └── Coordinator/
│       ├── AppCoordinator.swift
│       ├── Route.swift
│       └── AppDIContainer.swift
├── Patterns/
│   ├── ProductList/                        # Strategy
│   │   ├── ProductListViewModel.swift
│   │   ├── ProductListScreen.swift
│   │   ├── SortingStrategy.swift
│   │   └── Product.swift
│   ├── PizzaBuilder/                       # Builder
│   │   ├── PizzaBuilderScreen.swift
│   │   ├── PizzaBuilder.swift
│   │   └── Pizza.swift
│   ├── PhotoEnhancer/                     # Decorator
│   │   ├── PhotoEnhancerScreen.swift
│   │   ├── FilterDecorator.swift
│   │   └── ImageFilter.swift
│   ├── Checkout/                           # Facade
│   │   ├── CheckoutScreen.swift
│   │   ├── CheckoutViewModel.swift
│   │   └── PaymentFacade.swift
│   ├── DrawingBoard/                       # Command
│   │   ├── DrawingBoardScreen.swift
│   │   ├── DrawCommand.swift
│   │   └── DrawingCanvas.swift
│   ├── SupportTickets/                     # Chain of Responsibility
│   │   ├── SupportScreen.swift
│   │   └── Handler.swift
│   └── ... (others)
├── Core/
│   ├── ThemeManager.swift                  # Singleton
│   ├── ServiceProtocols.swift
│   └── Extensions/
│       └── Animation+Extensions.swift
└── README.md

```
## 📬 Contact
---
Chetan Purohit
iOS Developer
chetan81289@outlook.com
---
