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
        Group {
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
                    
                    if let questions = vm.questions {
                        QuestionView(question: questions[vm.questionIndex], isAnswerVisible: $vm.isAnswerVisible, secondsElapsed: $vm.secondsElapsed, handleNext: vm.handleNext)
                        
                        Spacer()
                        
                        Text("\(vm.questionIndex + 1) / \(questions.count)")
                            .exSmallBold()
                            .foregroundColor(Color.white)
                            .frame(width: 64, height: 32)
                            .background(Color.lightBg)
                            .cornerRadius(16)
                    }
                }
            } else if(vm.route == .result) {
                ResultView(eo: self.eo, questionNum: vm.questions?.count ?? 0, correctNum: vm.correctNum)
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
