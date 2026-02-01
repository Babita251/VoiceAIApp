//
//  VoiceAIViewModel.swift
//  VoiceAIApp
//
//  Created by Babita Pal on 31/01/26.
//

import Foundation
import SwiftUI

@MainActor
final class VoiceAIViewModel: ObservableObject {

    @Published var spokenText = ""
    @Published var aiResponse = ""
    @Published var isListening = false
    @Published var errorMessage: String?
    @Published var intentResult: VoiceIntent?
    private let speechService = SpeechService()
    private let aiService = AIService()

    func startListening() {
        Task {
            let granted = await speechService.requestPermission()
            guard granted else {
                errorMessage = "Speech permission denied"
                return
            }

            do {
                isListening = true
                spokenText = ""
                aiResponse = ""

                try speechService.startListening { text in
                    self.spokenText = text
                }
            } catch {
                errorMessage = "Failed to start listening"
            }
        }
    }
    func stopAndAnalyze() {
        isListening = false
        speechService.stopListening()

        Task {
            intentResult = try await aiService.analyzeVoice(spokenText)
        }
    }

  
}
