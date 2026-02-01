# Voice AI Assistant (SwiftUI)

An iOS Voice AI Assistant app built using SwiftUI and Apple's Speech framework.  
The app captures user voice input, converts speech to text, and analyzes the text using an AI service (currently mocked) to determine user intent.

This project demonstrates how to build voice-driven experiences and structure AI-ready architecture in an iOS application.

---

## 🚀 Features

- Voice input using Speech framework
- Speech-to-Text conversion
- AI intent analysis (mocked response)
- Displays recognized intent, action, and time
- Built with SwiftUI
- Async/Await based API design
- Clean and modular architecture

---

## 🧠 AI Architecture

The app uses an `AIService` layer that can later be replaced with a real Generative AI / LLM API.

Current implementation uses a mock JSON response:

```swift
{
  "intent": "reminder",
  "action": "submit the report",
  "time": "tomorrow"
}

## 📸 Screenshots

<img width="1206" height="2622" alt="screen1" src="https://github.com/user-attachments/assets/b1a2b6b9-a207-4955-840e-c27aeebaf6b8" />

<img width="1206" height="2622" alt="screen2" src="https://github.com/user-attachments/assets/7e78437d-b9a9-4086-b1ff-fe6ffb27e797" />

