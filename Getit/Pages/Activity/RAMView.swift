//
//  RAMView.swift
//  Getit
//
//  Created by kaorulego5x on 14/9/22.
//

import SwiftUI
import WrappingHStack

struct RAMView: View {
    @Binding var session: Session
    @Binding var sessionIndex: Int
    var handleNext: () -> Void
    @StateObject var speechRecognizer = SpeechRecognizer()
    @StateObject var speaker = Speaker()
    @StateObject var vm = RAMViewModel()
    
    init(session: Binding<Session>, sessionIndex: Binding<Int>, handleNext: @escaping () -> Void) {
        self._session = session
        self._sessionIndex = sessionIndex
        self.handleNext = handleNext
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
                .lgJa()
                .foregroundColor(Color.white)
            
            WrappingHStack(self.vm.enParts) { part in
                Text(part.text)
                    .getit()
                    .foregroundColor(part.isSpeeched ? Color.white : Color.white.opacity(0.5))
            }
            
            Spacer()
            
            Button(action:{
                self.handleNext()
            }){
                HStack(spacing:0){
                    if(!self.vm.isCompleted) {
                        LottieView(name: "listening", loopMode: .loop)
                                .frame(width: 120, height: 120)
                                .frame(maxWidth: .infinity)
                    } else {
                        Text("次へ進む")
                            .smallJaBold()
                            .foregroundColor(.text)
                            .padding(.bottom, 1)
                    }
                }
                .frame(maxWidth:.infinity)
                .frame(height: 56)
                .background(LinearGradient(gradient: Color.learnGrad, startPoint: .leading, endPoint: .trailing))
                .opacity(self.vm.isCompleted ? 1 : 0.3)
                .cornerRadius(12)
            }
            .buttonStyle(GrowingButton())
            .disabled(!self.vm.isCompleted)
        }
        .padding(.horizontal, 20)
        .onChange(of: speechRecognizer.transcript) { value in
            self.vm.handleSpeechInput(speechRecognizer.transcript)
        }
        .onChange(of: self.vm.isCompleted) { value in
            if(value) {
                speechRecognizer.stopTranscribing()
            }
        }
        .onChange(of: session) { value in
            self.vm.reset(self.session)
            speechRecognizer.transcribe()
        }
        .onAppear() {
            self.vm.reset(self.session)
            speechRecognizer.transcribe()
        }
    }
}

struct RAMView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
