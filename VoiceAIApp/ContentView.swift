//
//  ContentView.swift
//  VoiceAIApp
//
//  Created by Babita Pal on 31/01/26.
//

import SwiftUI


struct ContentView: View {

    @StateObject private var viewModel = VoiceAIViewModel()

    var body: some View {
        VStack(spacing: 20) {

            // MARK: - Title
            Text("🎙️ Voice AI Assistant")
                .font(.title2)
                .bold()

            // MARK: - Live Transcription
            VStack(alignment: .leading, spacing: 8) {
                Text("You said:")
                    .font(.headline)

                Text(
                    viewModel.spokenText.isEmpty
                    ? (viewModel.isListening ? "Listening…" : "Tap Start and speak")
                    : viewModel.spokenText
                )
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
            }

            // MARK: - AI Reasoning Result
            if let intent = viewModel.intentResult {
                VStack(alignment: .leading, spacing: 6) {
                    Text("AI Reasoning")
                        .font(.headline)

                    Text("Intent: \(intent.intent)")
                    Text("Action: \(intent.action)")

                    if let time = intent.time {
                        Text("Time: \(time)")
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.green.opacity(0.15))
                .cornerRadius(10)
            }

            // MARK: - Error Message
            if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
            }

            // MARK: - Controls
            HStack(spacing: 12) {

                Button {
                    viewModel.startListening()
                } label: {
                    Text("Start")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .disabled(viewModel.isListening)

                Button {
                    viewModel.stopAndAnalyze()
                } label: {
                    Text("Stop & Analyze")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
                .disabled(!viewModel.isListening)
            }

            Spacer()
        }
        .padding()
    }
}


#Preview {
    ContentView()
}
