//
//  ShuffleView.swift
//  Getit
//
//  Created by kaorulego5x on 14/9/22.
//

import SwiftUI
import WrappingHStack

struct ShuffleView: View {
    @Binding var session: Session
    var handleNext: () -> Void
    var vm = ShuffleViewModel()
    
    init(session: Binding<Session>, handleNext: @escaping () -> Void) {
        self._session = session
        self.handleNext = handleNext
    }
    
    var body: some View {
        let isChoiceDone = self.vm.selectedCandidates.count == self.vm.answers.count
        VStack(alignment: .leading, spacing: 12){
            HStack(){
                Icon(IconName.squarePlus, 15)
                    .foregroundColor(Color.text)
                
                Text("和訳と合うように並べ替えよう！")
                    .smallJaBold()
                    .foregroundColor(Color.text)
                
                Spacer()
            }
            
            Text(session.phrase.ja)
                .lgJa()
                .foregroundColor(Color.white)
            
            WrappingHStack(self.vm.blanks, alignment: .leading) { blank in
                Group {
                    if(blank.isBlank) {
                        if(self.vm.selectedCandidates.count <= blank.answerIndex) {
                            HStack{}
                                .frame(width: 48, height: 32)
                                .background(Color.darkBg)
                                .cornerRadius(12)
                        } else {
                            Button(action: {
                                self.vm.unselectShuffleCandidate(self.vm.selectedCandidates[blank.answerIndex])
                            }) {
                                Text(blank.answerIndex == 0 || (blank.answerIndex > 0 && self.vm.blanks[blank.answerIndex - 1].placeHolder == "-") ? self.vm.selectedCandidates[blank.answerIndex].text.firstUppercased : self.vm.selectedCandidates[blank.answerIndex].text)
                                    .smallBold()
                                    .foregroundColor(Color.white)
                                    .frame(height: 32)
                                    .padding(.horizontal, 18)
                                    .background(Color.bg)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(Color.subText, lineWidth: 1)
                                    )
                            }
                        }
                    } else {
                        Text(blank.placeHolder)
                            .mainBold()
                            .foregroundColor(Color.white)
                    }
                }
                .padding(.bottom, 8)
            }
            
            Spacer()
            
            HStack() {
                if(self.vm.shuffleStatus == .correct) {
                    HStack(){
                        Spacer()
                        Icon(.check, 18)
                            .foregroundColor(.white)
                        Text("正解!")
                            .exLgBold()
                            .foregroundColor(.white)
                        Spacer()
                    }
                } else if(self.vm.shuffleStatus == .incorrect) {
                    HStack() {
                        Spacer()
                        
                        VStack(alignment: .center){
                            HStack(){
                                Icon(.x, 18)
                                    .foregroundColor(.orange)
                                Text("不正解...")
                                    .exLgBold()
                                    .foregroundColor(.orange)
                            }
                            Text("正解例: \(self.session.phrase.en)")
                                .mainBold()
                                .foregroundColor(.orange)
                        }

                        
                        Spacer()
                    }
                }
            }
            
            WrappingHStack(self.vm.candidates, alignment: .center) { choice in
                let isSelected = self.vm.selectedCandidates.contains(where: {$0.position == choice.position})
                Button(action: {
                    self.vm.selectShuffleCandidate(choice)
                }) {
                    Text(choice.text)
                        .mainBold()
                        .foregroundColor(isSelected ? Color.darkBg : Color.white)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 24)
                        .background(isSelected ? Color.darkBg : Color.bg)
                        .cornerRadius(36)
                        .overlay(
                            RoundedRectangle(cornerRadius: 36)
                                .stroke(isSelected ? Color.darkBg : Color.subText, lineWidth: 1)
                        )
                        .padding(.bottom, 12)
                }
                .buttonStyle(GrowingButton())
                .disabled(isSelected)
            }
            
            Button(action:{
                if(self.vm.shuffleStatus == .selecting) {
                    self.vm.validateShuffleChoice()
                } else {
                    self.handleNext()
                }
            }){
                HStack(spacing:0){
                    Text(self.vm.shuffleStatus == .selecting ? "送信" : "次へ進む")
                        .smallJaBold()
                        .foregroundColor(.text)
                        .padding(.bottom, 1)
                        .animation(nil)
                }
                .frame(maxWidth:.infinity)
                .frame(height: 56)
                .background(LinearGradient(gradient: Color.learnGrad, startPoint: .leading, endPoint: .trailing))
                .opacity(isChoiceDone ? 1 : 0.3)
                .cornerRadius(12)
            }
            .disabled(!isChoiceDone)
            .buttonStyle(GrowingButton())
        }
        .padding(.horizontal, 20)
        .onChange(of: self.session) { newSession in
            self.vm.reset(newSession)
        }
        .onAppear() {
            self.vm.reset(self.session)
        }
    }
}

struct ShuffleView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
