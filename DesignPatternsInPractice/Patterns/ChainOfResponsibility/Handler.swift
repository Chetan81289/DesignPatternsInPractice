//
//  Handler.swift
//  DesignPatternsInPractice
//
//  Created by Chetan purohit on 08/05/26.
//

import Foundation

// MARK: - Request Model

struct SupportRequest {
    let description: String
    let priority: Priority

    enum Priority: String, CaseIterable {
        case low = "Low"
        case medium = "Medium"
        case high = "High"
    }
}

// MARK: - Handler Protocol

protocol SupportHandler: AnyObject {
    var next: SupportHandler? { get set }
    /// Attempts to handle the request. Returns a resolution message, or nil to pass it on.
    func handle(_ request: SupportRequest) -> String?
}

// MARK: - Concrete Handlers

/// Basic support handles low‑priority requests.
final class BasicSupportHandler: SupportHandler {
    var next: SupportHandler?

    func handle(_ request: SupportRequest) -> String? {
        if request.priority == .low {
            return "Basic Support resolved: “\(request.description)”"
        }
        return next?.handle(request)
    }
}

/// Premium support handles medium‑priority requests.
final class PremiumSupportHandler: SupportHandler {
    var next: SupportHandler?

    func handle(_ request: SupportRequest) -> String? {
        if request.priority == .medium {
            return "Premium Support resolved: “\(request.description)”"
        }
        return next?.handle(request)
    }
}

/// Manager handles high‑priority requests, or anything that falls through.
final class ManagerHandler: SupportHandler {
    var next: SupportHandler?

    func handle(_ request: SupportRequest) -> String? {
        // Manager handles everything that reaches here
        return "Manager resolved: “\(request.description)”"
    }
}

// MARK: - Chain Builder

/// Creates the standard support chain: Basic → Premium → Manager.
func makeSupportChain() -> SupportHandler {
    let basic = BasicSupportHandler()
    let premium = PremiumSupportHandler()
    let manager = ManagerHandler()

    basic.next = premium
    premium.next = manager
    // Manager has no next (end of chain)

    return basic
}
