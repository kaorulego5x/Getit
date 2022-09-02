//
//  QuestionView.swift
//  Getit
//
//  Created by kaorulego5x on 2022/09/01.
//

import SwiftUI

struct QuestionView: View {
    @ObservedObject var vm: QuestionViewModel
    var question: Question
    var handleNext: () -> Void
    
    init(_ question: Question, _ handleNext: @escaping () -> Void) {
        self.question = question
        self.handleNext = handleNext
    }
    
    var body: some View {
        if(!vm.isAnswerVisible) {
            VStack(spacing: 6){
                Text("使う単語")
                    .exSmallJaBold()
                    .foregroundColor(Color.subText)
                
                Text("Get")
                    .exLgBold()
                    .foregroundColor(Color.white)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 24)
                    .background(Color.lightBg)
                    .cornerRadius(8)
            }
            .padding(.bottom, 24)
        }
        
        
        ZStack(alignment: .bottom){
            Text("ジェニファーの美貌は母親譲りだ。")
                .exLgBold()
                .multilineTextAlignment(.center)
                .foregroundColor(Color.white)
                .padding(.vertical, 56)
                .frame(maxWidth: .infinity)
                .background(Color.lightBg)
                .cornerRadius(8)
            
            if(!vm.isAnswerVisible) {
                GeometryReader {
                    geometry in
                    HStack {
                        
                    }
                    .frame(height: 16)
                    .frame(width: geometry.size.width * vm.secondsElapsed / 5, alignment: .leading)
                    .background(LinearGradient(gradient: Color.learnGrad, startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(8)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(height: 16)
            }
        }
        .padding(.horizontal, 20)
        
        if(!vm.isAnswerVisible) {
            HStack {
                Spacer()
                HStack(){
                    Icon(IconName.clock, 12)
                        .foregroundColor(Color.subText)
                    Text(String(format: "%.1f", vm.secondsElapsed))
                        .small()
                        .foregroundColor(Color.subText)
                        .frame(width: 40)
                }
            }
            .padding(.horizontal, 20)
        }
        
        if(vm.isAnswerVisible) {
            VStack(){
                Icon(IconName.down, 12)
                    .foregroundColor(Color.white)
                    .padding(.vertical, 12)
                Text("Jennifer gets her good looks from her mother.")
                    .exLgBold()
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.white)
                
                Spacer()
                
                Text("訳せた？")
                    .smallJaBold()
                    .foregroundColor(Color.white)
                
                HStack(spacing: 64){
                    Button(action: {
                        
                    }){
                        Icon(IconName.x, 32)
                            .foregroundColor(Color.white)
                            .frame(width: 72, height: 72)
                            .background(Color.lightBg)
                            .cornerRadius(8)
                    }
                    
                    Button(action: {
                        
                    }){
                        Icon(IconName.check, 20)
                            .foregroundColor(Color.white)
                            .frame(width: 72, height: 72)
                            .background(Color.lightBg)
                            .cornerRadius(8)
                    }
                    
                }
                .padding(.bottom, 32)
            }
            
        }
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView()
    }
}
