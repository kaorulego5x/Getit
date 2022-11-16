//
//  IdiomView.swift
//  Getit
//
//  Created by kaorulego5x on 14/9/22.
//

import SwiftUI
import WrappingHStack

struct IdiomView: View {
    var session: Session
    var baseEnSentence: String
    var idiomChoices: [IdiomChoice]
    var displayIdiomChoices: [IdiomChoice]
    var selectedChoiceIndex: Int
    var isIdiomChoiceDone: Bool
    var selectChoice: (IdiomChoice) -> Void
    let validateIdiomChoice: () -> Void
    let handleNext: () -> Void
    
    init(session: Session, idiomChoices: [IdiomChoice], displayIdiomChoices: [IdiomChoice], selectedChoiceIndex: Int, isIdiomChoiceDone: Bool, selectChoice: @escaping (IdiomChoice) -> Void, validateIdiomChoice: @escaping () -> Void, handleNext: @escaping () -> Void) {
        self.session = session
        var enComponents = session.phrase.en.components(separatedBy: " ")
        if let blankIndex = enComponents.firstIndex(where: { $0.contains("`")}) {
            let correctMatches = matches(for: "`.*`", in: enComponents[blankIndex])
            enComponents[blankIndex] = enComponents[blankIndex].replacingOccurrences(of: correctMatches[0], with: "#")
        } else {
            print("Error occurred while generating en sentence")
        }
        self.baseEnSentence = enComponents.joined(separator: " ")
        self.idiomChoices = idiomChoices
        self.displayIdiomChoices = displayIdiomChoices
        self.selectedChoiceIndex = selectedChoiceIndex
        self.isIdiomChoiceDone = isIdiomChoiceDone
        self.selectChoice = selectChoice
        self.validateIdiomChoice = validateIdiomChoice
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
            
            Text(baseEnSentence.replacingOccurrences(of: "#", with: selectedChoiceIndex >= 0 ? self.idiomChoices[self.selectedChoiceIndex].text : "_"))
                .getit()
                .foregroundColor(Color.white)
                .animation(nil)
            
            Spacer()
            
            HStack() {
                if(self.isIdiomChoiceDone) {
                    if(self.selectedChoiceIndex == 0) {
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
                                Text("正解例: \(self.idiomChoices[0].text)")
                                    .mainBold()
                                    .foregroundColor(.orange)
                            }
                            
                            Spacer()
                        }
                    }
                }
            }
            
            WrappingHStack(displayIdiomChoices, alignment: .center) { choice in
                Button(action: {
                    self.selectChoice(choice)
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
                .disabled(self.isIdiomChoiceDone)
            }
            
            Button(action:{
                if(self.isIdiomChoiceDone) {
                    self.handleNext()
                } else {
                    self.validateIdiomChoice()
                }
            }){
                HStack(spacing:0){
                    Text(self.isIdiomChoiceDone ? "次へ進む" : "送信")
                        .smallJaBold()
                        .foregroundColor(.text)
                        .padding(.bottom, 1)
                        .animation(nil)
                }
                .frame(maxWidth:.infinity)
                .frame(height: 56)
                .background(LinearGradient(gradient: Color.learnGrad, startPoint: .leading, endPoint: .trailing))
                .opacity(self.selectedChoiceIndex == -1 ? 0.3 : 1)
                .cornerRadius(12)
            }
            .disabled(self.selectedChoiceIndex == -1)
            .buttonStyle(GrowingButton())
        }
        .padding(.horizontal, 20)
    }
}

struct IdiomView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
