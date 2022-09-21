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
                        
                        Text("\(vm.sessionIndex + 1) / \(vm.sessions.count)")
                            .exSmallBold()
                            .foregroundColor(Color.white)
                            .frame(width: 64, height: 32)
                            .background(Color.lightBg)
                            .cornerRadius(16)
                        
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
                        case .ram:
                            RAMView(session: session, enParts: vm.enParts, handleNext: vm.handleNext, handleSpeechInput: vm.handleSpeechInput, isCompleted: $vm.isCompleted)
                        case .idiom:
                            IdiomView(session: session, idiomChoices: vm.idiomChoices, displayIdiomChoices: vm.displayIdiomChoices, selectedChoiceIndex: vm.selectedChoiceIndex, isIdiomChoiceDone: vm.isIdiomChoiceDone, selectChoice: vm.selectChoice, validateIdiomChoice: vm.validateIdiomChoice, handleNext: vm.handleNext)
                        case .shuffle:
                            ShuffleView()
                        }
                    }
                    
                    Spacer()
                        .frame(height: 32)
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
