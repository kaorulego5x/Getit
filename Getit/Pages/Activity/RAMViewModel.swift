//
//  RAMViewModel.swift
//  Getit
//
//  Created by kaorulego5x on 30/11/22.
//

import Foundation
import AVFoundation
import SwiftUI

struct EnPart: Identifiable {
    var text: String
    var isSpeeched: Bool
    var id: UUID
}

class RAMViewModel: ObservableObject {
    @Published var enParts: [EnPart] = []
    @Published var isCompleted: Bool = false
    @Published var sessionIndex: Int = 0
    
    func reset(_ session: Session, _ sessionIndex: Int) {
        self.sessionIndex = sessionIndex
        self.enParts = session.phrase.en.components(separatedBy: " ").map { component in
            return EnPart(text: component.replacingOccurrences(of: "`", with: ""), isSpeeched: false, id: UUID())
        }
        self.isCompleted = false
        self.assistSpeech(sessionIndex);
    }
    
    func handleSpeechInput(_ transcript: String) {
        let inputParts = transcript.lowercased().components(separatedBy: " ")
        var carry = 0
        for (index, part) in enParts.enumerated() {
            var a: String = part.text.lowercased()
            if(a.contains("!?") || a.contains("?!") || a.contains("!!")) {
                a.removeLast()
                a.removeLast()
            } else if(a.contains(",") || a.contains(".") || a.contains("…") || a.contains("!") || a.contains("?")) {
                a.removeLast()
            }
                
            if(part.isSpeeched) {
                continue
            } else if(inputParts.contains(a)) {
                withAnimation(.easeOut(duration: 0.2)) {
                    self.enParts[index].isSpeeched = true
                }
                if(index == enParts.count - 1) {
                    self.handleSpeechCompleted()
                }
                if(carry == 1) {
                    withAnimation(.easeOut(duration: 0.2)) {
                        self.enParts[index-1].isSpeeched = true
                    }
                }
            } else if (carry == 0){
                carry = 1
            } else {
                break
            }
        }
    }
    
    private func handleSpeechCompleted() {
        for (index, _) in enParts.enumerated() {
            self.enParts[index].isSpeeched = true;
        }
        withAnimation(.easeOut(duration: 0.2)) {
            self.isCompleted = true
        }
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
    func assistSpeech(_ idx: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) {
            if(idx == self.sessionIndex) {
                self.handleSpeechCompleted()
            }
        }
    }
}

internal class Speaker: NSObject, ObservableObject {
    internal var errorDescription: String? = nil
    private let synthesizer: AVSpeechSynthesizer = AVSpeechSynthesizer()
    @Published var isSpeaking: Bool = false
    @Published var isShowingSpeakingErrorAlert: Bool = false

    override init() {
        super.init()
        self.synthesizer.delegate = self
    }

    internal func speak(_ text: String, language: String) {
        do {
            let utterance = AVSpeechUtterance(string: text)
            utterance.voice = AVSpeechSynthesisVoice(language: language)
            
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            self.synthesizer.speak(utterance)
        } catch let error {
            self.errorDescription = error.localizedDescription
            isShowingSpeakingErrorAlert.toggle()
        }
    }
    
    internal func stop() {
        self.synthesizer.stopSpeaking(at: .immediate)
    }
}

extension Speaker: AVSpeechSynthesizerDelegate {
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        self.isSpeaking = true
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance) {
        self.isSpeaking = false
        try? AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        self.isSpeaking = false
        try? AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
    }
}
