//
//  SupportViewModel.swift
//  DesignPatternsInPractice
//
//  Created by Chetan purohit on 08/05/26.
//

import SwiftUI
import Combine

@MainActor
final class SupportViewModel: ObservableObject {
    @Published var requestText = ""
    @Published var selectedPriority: SupportRequest.Priority = .low
    @Published var resultMessage: String?
    @Published var isProcessing = false

    private let chain = makeSupportChain()

    var canSend: Bool {
        !requestText.trimmingCharacters(in: .whitespaces).isEmpty && !isProcessing
    }

    func sendRequest() {
        guard canSend else { return }

        isProcessing = true
        let request = SupportRequest(description: requestText, priority: selectedPriority)

        // Simulate a bit of network delay for realism
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let self = self else { return }
            if let response = self.chain.handle(request) {
                self.resultMessage = response
            } else {
                self.resultMessage = "No one could handle your request."
            }
            self.isProcessing = false
        }
    }

    func reset() {
        requestText = ""
        resultMessage = nil
    }
}

