//
//  RAMViewModel.swift
//  Getit
//
//  Created by kaorulego5x on 30/11/22.
//

import Foundation
import SwiftUI

class RAMViewModel: ObservableObject {
    // let assistSpeech: (Int) -> Void;
    
    // RAM
    @Published var enParts: [EnPart] = []
    @Published var isCompleted: Bool = false
    
    /*
    init(assistSpeech: @escaping (Int) -> Void) {
        self.assistSpeech = assistSpeech
    }
    */
    
    func reset(_ session: Session) {
        self.enParts = session.phrase.en.components(separatedBy: " ").map { component in
            return EnPart(text: component.replacingOccurrences(of: "`", with: ""), isSpeeched: false, id: UUID())
        }
        self.isCompleted = false
        // self.assistSpeech(0);
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
}
