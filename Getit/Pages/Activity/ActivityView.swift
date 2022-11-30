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
                            Icon(IconName.x, 18)
                                .foregroundColor(Color.subText)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 24)
                    .padding(.bottom, 30)
                    
                    if let session = vm.sessions[vm.sessionIndex] {
                        if let _ = vm.currentSession {
                            switch(session.sessionType) {
                            case .ram:
                                RAMView(session: Binding($vm.currentSession)!, sessionIndex: $vm.sessionIndex, handleNext: vm.handleNext)
                            case .idiom:
                                IdiomView(session: session, idiomChoices: vm.idiomChoices, displayIdiomChoices: vm.displayIdiomChoices, selectedChoiceIndex: vm.selectedChoiceIndex, isIdiomChoiceDone: vm.isIdiomChoiceDone, selectChoice: vm.selectChoice, validateIdiomChoice: vm.validateIdiomChoice, handleNext: vm.handleNext)
                            case .shuffle:
                                ShuffleView(session: session, blanks: vm.blanks, answers: vm.answers, candidates: vm.candidates, selectedCandidates: vm.selectedCandidates, shuffleStatus: vm.shuffleStatus, selectShuffleCandidate: vm.selectShuffleCandidate, unselectShuffleCandidate: vm.unselectShuffleCandidate, handleNext: vm.handleNext, validateShuffleChoice: vm.validateShuffleChoice)
                            }
                        }
                    }
                    
                    Spacer()
                        .frame(height: 32)
                }
            } else if(vm.route == .result) {
                ResultView(eo: self.eo, phraseNum: vm.sessions.count ?? 0, correctNum: vm.correctNum)
            }
        }
        .onChange(of: vm.sessionIndex) { newIndex in
            vm.currentSession = vm.sessions[newIndex]
        }
        .background(Color.bg.ignoresSafeArea())
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
