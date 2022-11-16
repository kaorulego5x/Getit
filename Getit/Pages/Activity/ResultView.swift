//
//  ResultView.swift
//  Getit
//
//  Created by kaorulego5x on 2022/09/04.
//

import SwiftUI

struct ResultView: View {
    let eo: AppViewModel
    var phraseNum: Int
    var correctNum: Int
    @StateObject var vm: ResultViewModel
    
    init(eo: AppViewModel, phraseNum: Int, correctNum: Int) {
        self.eo = eo
        self.phraseNum = phraseNum
        self.correctNum = correctNum
        self._vm = StateObject(wrappedValue: ResultViewModel(eo: eo))
    }
    
    var messages = ["Good Job! Keep it up!", "Fantastic!"]
    
    var body: some View {
        VStack(){
            Spacer()
            
            VStack(spacing: 16) {
                HStack(spacing: 8){
                    Text(messages.randomElement()!)
                        .getit()
                        .foregroundColor(Color.white)
                }
            }
            
            Spacer()
            
            Button(action:{
                vm.transitToHome()
            }){
                HStack(spacing:0){
                    Text("ホームに戻る")
                        .smallJaBold()
                        .foregroundColor(.text)
                        .padding(.bottom, 1)
                }
                .frame(maxWidth:.infinity)
                .frame(height: 56)
                .background(LinearGradient(gradient: Color.learnGrad, startPoint: .leading, endPoint: .trailing))
                .cornerRadius(12)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 32)
        }
        .onAppear(){
            self.vm.completeUnit()
        }
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
