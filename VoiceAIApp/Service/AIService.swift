//
//  AIService.swift
//  VoiceAIApp
//
//  Created by Babita Pal on 31/01/26.
//

import Foundation

struct VoiceIntent: Decodable {
    let intent: String
    let action: String
    let time: String?
}

final class AIService {

    func analyzeVoice(_ text: String) async throws -> VoiceIntent {

        // 🔹 Mock reasoning result (for learning)
        let mockJSON = """
        {
          "intent": "reminder",
          "action": "submit the report",
          "time": "tomorrow"
        }
        """

        let data = Data(mockJSON.utf8)
        return try JSONDecoder().decode(VoiceIntent.self, from: data)
    }
}
