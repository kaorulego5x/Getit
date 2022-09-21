//
//  RAMView.swift
//  Getit
//
//  Created by kaorulego5x on 14/9/22.
//

import SwiftUI
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
            HStack(){
                Icon(IconName.sound, 15)
                    .foregroundColor(Color.text)
                
                Text("声に出そう！")
                    .smallJaBold()
                    .foregroundColor(Color.text)
                
                Spacer()
            }
           
            Text(session.phrase.ja)
                .mainJa()
                .foregroundColor(Color.white)
            
            WrappingHStack(self.enParts) { part in
                Text(part.text)
                    .getit()
                    .foregroundColor(part.isSpeeched ? Color.white : Color.white.opacity(0.5))
            }
            
            Spacer()
            
            Button(action:{
                self.handleNext()
            }){
                HStack(spacing:0){
                    Text("次へ進む")
                        .smallJaBold()
                        .foregroundColor(.text)
                        .padding(.bottom, 1)
                }
                .frame(maxWidth:.infinity)
                .frame(height: 56)
                .background(LinearGradient(gradient: Color.learnGrad, startPoint: .leading, endPoint: .trailing))
                .opacity(self.isCompleted ? 1 : 0.3)
                .cornerRadius(12)
            }
            .buttonStyle(GrowingButton())
            .disabled(!self.isCompleted)
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
