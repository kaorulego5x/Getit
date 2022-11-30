//
//  IdiomView.swift
//  Getit
//
//  Created by kaorulego5x on 14/9/22.
//

import SwiftUI
import WrappingHStack

struct IdiomView: View {
    @Binding var session: Session
    let handleNext: () -> Void
    @StateObject var vm = IdiomViewModel()
    
    init(session: Binding<Session>, handleNext: @escaping () -> Void) {
        self._session = session
        self.handleNext = handleNext
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12){
            HStack(){
                Icon(IconName.squarePlus, 15)
                    .foregroundColor(Color.text)
                Text("空欄を埋めよう！")
                    .smallJaBold()
                    .foregroundColor(Color.text)
                Spacer()
            }
            
            Text(session.phrase.ja)
                .lgJa()
                .foregroundColor(Color.white)
            
            if let sentence = self.vm.baseEnSentence {
                Text(sentence.replacingOccurrences(of: "#", with: self.vm.selectedChoiceIndex >= 0 ? self.vm.idiomChoices[self.vm.selectedChoiceIndex].text : "_"))
                    .getit()
                    .foregroundColor(Color.white)
                    .animation(nil)
            }
            
            
            Spacer()
            
            HStack() {
                if(self.vm.isIdiomChoiceDone) {
                    if(self.vm.selectedChoiceIndex == 0) {
                        HStack(){
                            
                            Spacer()
                            Icon(.check, 18)
                                .foregroundColor(.white)
                            
                            Text("正解!")
                                .exLgBold()
                                .foregroundColor(.white)
                            
                            Spacer()
                        }
                    } else {
                        HStack {
                            Spacer()
                            
                            VStack(alignment: .center){
                                HStack(){
                                    Icon(.x, 18)
                                        .foregroundColor(.orange)
                                    Text("不正解...")
                                        .exLgBold()
                                        .foregroundColor(.orange)
                                }
                                Text("正解例: \(self.vm.idiomChoices[0].text)")
                                    .mainBold()
                                    .foregroundColor(.orange)
                            }
                            
                            Spacer()
                        }
                    }
                }
            }
            
            WrappingHStack(self.vm.displayIdiomChoices, alignment: .center) { choice in
                Button(action: {
                    self.vm.selectChoice(choice)
                }) {
                    Text(choice.text)
                        .mainBold()
                        .foregroundColor(Color.white)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 24)
                        .overlay(
                            RoundedRectangle(cornerRadius: 36)
                                .stroke(Color.subText, lineWidth: 1)
                        )
                        .padding(.bottom, 12)
                }
                .buttonStyle(GrowingButton())
                .disabled(self.vm.isIdiomChoiceDone)
            }
            
            Button(action:{
                if(self.vm.isIdiomChoiceDone) {
                    self.handleNext()
                } else {
                    self.vm.validateIdiomChoice()
                }
            }){
                HStack(spacing:0){
                    Text(self.vm.isIdiomChoiceDone ? "次へ進む" : "送信")
                        .smallJaBold()
                        .foregroundColor(.text)
                        .padding(.bottom, 1)
                        .animation(nil)
                }
                .frame(maxWidth:.infinity)
                .frame(height: 56)
                .background(LinearGradient(gradient: Color.learnGrad, startPoint: .leading, endPoint: .trailing))
                .opacity(self.vm.selectedChoiceIndex == -1 ? 0.3 : 1)
                .cornerRadius(12)
            }
            .disabled(self.vm.selectedChoiceIndex == -1)
            .buttonStyle(GrowingButton())
        }
        .padding(.horizontal, 20)
        .onChange(of: session) { newSession in
            self.vm.reset(session)
        }
        .onAppear() {
            self.vm.reset(session)
        }
    }
}

struct IdiomView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
