//
//  SupportScreen.swift
//  DesignPatternsInPractice
//
//  Created by Chetan purohit on 08/05/26.
//

import SwiftUI
import Combine

struct SupportScreen: View {
    @StateObject private var viewModel = SupportViewModel()

    var body: some View {
        Form {
            Section("Describe Your Issue") {
                TextField("What's happening?", text: $viewModel.requestText, axis: .vertical)
                    .lineLimit(3...6)
                    .disabled(viewModel.isProcessing)
            }

            Section("Priority") {
                Picker("Select Priority", selection: $viewModel.selectedPriority) {
                    ForEach(SupportRequest.Priority.allCases, id: \.self) { priority in
                        Text(priority.rawValue).tag(priority)
                    }
                }
                .pickerStyle(.segmented)
                .disabled(viewModel.isProcessing)
            }

            Section {
                Button(action: viewModel.sendRequest) {
                    HStack {
                        Spacer()
                        if viewModel.isProcessing {
                            ProgressView()
                                .tint(.white)
                        } else {
                            Text("Send Request")
                                .fontWeight(.semibold)
                        }
                        Spacer()
                    }
                    .padding(.vertical, 8)
                    .frame(maxWidth: .infinity)
                    .background(viewModel.canSend ? Color.blue : Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                .disabled(!viewModel.canSend)
            }

            if let result = viewModel.resultMessage {
                Section("Result") {
                    HStack {
                        Image(systemName: "checkmark.message.fill")
                            .foregroundColor(.green)
                        Text(result)
                            .font(.callout)
                    }
                    Button("Send Another") {
                        withAnimation { viewModel.reset() }
                    }
                }
            }
        }
        .navigationTitle("Support Tickets")
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
    }
}
