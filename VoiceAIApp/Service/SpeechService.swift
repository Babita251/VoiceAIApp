//
//  SpeechService.swift
//  VoiceAIApp
//
//  Created by Babita Pal on 31/01/26.
//

import Foundation
import Speech
import AVFoundation

final class SpeechService {

    private let recognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-IN"))
    private let audioEngine = AVAudioEngine()
    private var request: SFSpeechAudioBufferRecognitionRequest?
    private var task: SFSpeechRecognitionTask?

    func requestPermission() async -> Bool {
        await withCheckedContinuation { continuation in
            SFSpeechRecognizer.requestAuthorization { status in
                continuation.resume(returning: status == .authorized)
            }
        }
    }

    func startListening(onResult: @escaping (String) -> Void) throws {

        try configureAudioSession()   //
        
        request = SFSpeechAudioBufferRecognitionRequest()
        guard let request = request else { return }

        let inputNode = audioEngine.inputNode
        let format = inputNode.outputFormat(forBus: 0)

        inputNode.installTap(onBus: 0, bufferSize: 1024, format: format) {
            buffer, _ in
            request.append(buffer)
        }

        audioEngine.prepare()
        try audioEngine.start()

        task = recognizer?.recognitionTask(with: request) { result, error in
            if let text = result?.bestTranscription.formattedString {
                onResult(text)
            }
        }
    }

    private func configureAudioSession() throws {
        let session = AVAudioSession.sharedInstance()
        try session.setCategory(
            .record,
            mode: .measurement,
            options: [.duckOthers]
        )
        try session.setActive(true, options: .notifyOthersOnDeactivation)
    }

    func stopListening() {
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
        request?.endAudio()
        task?.cancel()

        try? AVAudioSession.sharedInstance().setActive(false)
    }

    
}
