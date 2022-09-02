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
    
    init(){
        _vm = StateObject(wrappedValue: ActivityViewModel())
    }
    
    var body: some View {
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
                QuestionView(questions[vm.questionIndex], vm.handleNext)
                
                Spacer()
                
                Text("\(vm.questionIndex + 1) / \(questions.count)")
                    .exSmallBold()
                    .foregroundColor(Color.white)
                    .frame(width: 64, height: 32)
                    .background(Color.lightBg)
                    .cornerRadius(16)
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
