//
//  ShuffleView.swift
//  Getit
//
//  Created by kaorulego5x on 14/9/22.
//

import SwiftUI
import WrappingHStack

struct ShuffleView: View {
    var session: Session
    var blanks: [ShuffleBlank]
    var answers: [String]
    var candidates: [ShuffleCandidate]
    var selectedCandidates: [ShuffleCandidate]
    var shuffleStatus: ShuffleStatus
    var selectShuffleCandidate: (ShuffleCandidate) -> Void
    var unselectShuffleCandidate: (ShuffleCandidate) -> Void
    var handleNext: () -> Void
    var validateShuffleChoice: () -> Void
    
    init(session: Session, blanks: [ShuffleBlank], answers: [String], candidates: [ShuffleCandidate], selectedCandidates: [ShuffleCandidate], shuffleStatus: ShuffleStatus, selectShuffleCandidate: @escaping (ShuffleCandidate) -> Void, unselectShuffleCandidate: @escaping (ShuffleCandidate) -> Void, handleNext: @escaping () -> Void, validateShuffleChoice: @escaping () -> Void) {
        self.session = session
        self.blanks = blanks
        self.answers = answers
        self.candidates = candidates
        self.selectedCandidates = selectedCandidates
        self.shuffleStatus = shuffleStatus
        self.selectShuffleCandidate = selectShuffleCandidate
        self.unselectShuffleCandidate = unselectShuffleCandidate
        self.handleNext = handleNext
        self.validateShuffleChoice = validateShuffleChoice
    }
    
    var body: some View {
        let isChoiceDone = self.selectedCandidates.count == self.answers.count
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
            
            WrappingHStack(self.blanks, alignment: .leading) { blank in
                Group {
                    if(blank.isBlank) {
                        if(self.selectedCandidates.count <= blank.answerIndex) {
                            HStack{}
                                .frame(width: 48, height: 32)
                                .background(Color.darkBg)
                                .cornerRadius(12)
                        } else {
                            Button(action: {
                                self.unselectShuffleCandidate(self.selectedCandidates[blank.answerIndex])
                            }) {
                                Text(blank.answerIndex == 0 || (blank.answerIndex > 0 && self.blanks[blank.answerIndex - 1].placeHolder == "-") ? self.selectedCandidates[blank.answerIndex].text.firstUppercased : self.selectedCandidates[blank.answerIndex].text)
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
                if(self.shuffleStatus == .correct) {
                    HStack(){
                        Spacer()
                        Icon(.check, 18)
                            .foregroundColor(.white)
                        Text("正解!")
                            .exLgBold()
                            .foregroundColor(.white)
                        Spacer()
                    }
                } else if(self.shuffleStatus == .incorrect) {
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
            
            WrappingHStack(candidates, alignment: .center) { choice in
                let isSelected = selectedCandidates.contains(where: {$0.position == choice.position})
                Button(action: {
                    self.selectShuffleCandidate(choice)
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
                if(self.shuffleStatus == ShuffleStatus.selecting) {
                    self.validateShuffleChoice()
                } else {
                    self.handleNext()
                }
            }){
                HStack(spacing:0){
                    Text(self.shuffleStatus == ShuffleStatus.selecting ? "送信" : "次へ進む")
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
    }
}

struct ShuffleView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
