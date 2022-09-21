//
//  RAMView.swift
//  Getit
//
//  Created by kaorulego5x on 14/9/22.
//

import SwiftUIgit 
import WrappingHStack

struct RAMView: View {
    var session: Session
    var enParts: [EnPart]
    var handleNext: () -> Void;
    var handleSpeechInput: (String) -> Void;
    @Binding var isCompleted: Bool
    @StateObject var speechRecognizer = SpeechRecognizer()
    @StateObject var speaker = Speaker()
    
    init(session: Session, enParts: [EnPart], handleNext: @escaping () -> Void, handleSpeechInput: @escaping (String) -> Void, isCompleted: Binding<Bool>) {
        self.session = session
        self.enParts = enParts
        self.handleNext = handleNext
        self.handleSpeechInput = handleSpeechInput
        self._isCompleted = isCompleted
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12){
            Text(session.phrase.ja)
                .mainJa()
                .foregroundColor(Color.white)
            
            WrappingHStack(self.enParts) { part in
                Text(part.text)
                    .getit()
                    .foregroundColor(part.isSpeeched ? Color.white : Color.white.opacity(0.5))
            }
        }
        .padding(.horizontal, 20)
        .onChange(of: speechRecognizer.transcript) { value in
            self.handleSpeechInput(speechRecognizer.transcript)
        }
        .onChange(of: self.isCompleted) { value in
            if(value) {
                speechRecognizer.stopTranscribing()
            }
        }
        .onAppear() {
            speechRecognizer.transcribe()
            // speaker.speak(session.phrase.en, language: "en-US")
        }
    }
}

struct RAMView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
