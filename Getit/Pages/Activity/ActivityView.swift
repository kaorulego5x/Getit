//
//  ActivityView.swift
//  Getit
//
//  Created by kaorulego5x on 2022/07/28.
//

import SwiftUI

struct ActivityView: View {
    @StateObject var vm: ActivityViewModel
    @EnvironmentObject var eo: AppViewModel
    
    init(eo: AppViewModel){
        _vm = StateObject(wrappedValue: ActivityViewModel(eo: eo))
    }
    
    var body: some View {
        VStack {
            if(vm.route == .loading) {
                LoadingView()
                    .onAppear(){
                        vm.fetchUnit()
                    }
            } else if(vm.route == .activity) {
                VStack(){
                    HStack(){
                        Icon(IconName.sound, 15)
                            .foregroundColor(Color.text)
                            
                        Text("声に出して訳そう！")
                            .smallJaBold()
                            .foregroundColor(Color.text)
                        
                        Spacer()
                        
                        Button(action: {
                            eo.transit(Tab.home)
                        }){
                            Icon(IconName.x, 30)
                                .foregroundColor(Color.subText)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 24)
                    .padding(.bottom, 30)
                    
                    if let session = vm.currentSession {
                        switch(session.sessionType) {
                        case .rfm:
                            RFMView(session: session, enParts: vm.enParts, handleNext: vm.handleNext, handleSpeechInput: vm.handleSpeechInput, isCompleted: $vm.isCompleted)
                        case .shuffle:
                            ShuffleView()
                        case .idiom:
                            IdiomView()
                        }
                    }
                        
                    Text("\(vm.sessionIndex + 1) / \(vm.sessions.count)")
                        .exSmallBold()
                        .foregroundColor(Color.white)
                        .frame(width: 64, height: 32)
                        .background(Color.lightBg)
                        .cornerRadius(16)
                    
                    Spacer()
                    
                    Button(action:{
                        vm.handleNext()
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
                        .opacity(vm.isCompleted ? 1 : 0.3)
                        .cornerRadius(12)
                    }
                    .buttonStyle(GrowingButton())
                    .padding(.horizontal, 20)
                    .padding(.bottom, 48)
                }
            } else if(vm.route == .result) {
                ResultView(eo: self.eo, phraseNum: vm.sessions.count ?? 0, correctNum: vm.correctNum)
            }
        }
        .background(Color.bg.ignoresSafeArea())
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
