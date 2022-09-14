//
//  QuestionView.swift
//  Getit
//
//  Created by kaorulego5x on 2022/09/01.
//

import SwiftUI
import Combine

struct QuestionView: View {
    @StateObject var vm: QuestionViewModel
    var question: Question
    var handleNext: (Bool) -> Void
    @Binding var isAnswerVisible: Bool
    @Binding var secondsElapsed: Double
    
     
    init(question: Question, isAnswerVisible: Binding<Bool>, secondsElapsed: Binding<Double>, handleNext: @escaping (Bool) -> Void) {
        self.question = question
        self.handleNext = handleNext
        self._isAnswerVisible = isAnswerVisible
        self._secondsElapsed = secondsElapsed
        _vm = StateObject(wrappedValue: QuestionViewModel(handleNext))
    }
    
    var body: some View {
            VStack(spacing: 0){
                if(!isAnswerVisible) {
                    VStack(spacing: 6){
                        Text("使う単語")
                            .exSmallJaBold()
                            .foregroundColor(Color.subText)
                        
                        Text(self.question.unitId.components(separatedBy: "-")[0].firstUppercased)
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
                    Text(question.ja)
                        .exLgBold()
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.white)
                        .padding(.vertical, 56)
                        .padding(.horizontal, 20)
                        .frame(maxWidth: .infinity)
                        .background(Color.lightBg)
                        .cornerRadius(8)
                    
                    if(!isAnswerVisible) {
                        GeometryReader {
                            geometry in
                            HStack {
                                
                            }
                            .frame(height: 16)
                            .frame(width: geometry.size.width * secondsElapsed / 5, alignment: .leading)
                            .background(LinearGradient(gradient: Color.learnGrad, startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(8)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .frame(height: 16)
                    }
                }
                .padding(.horizontal, 20)
                
                if(!isAnswerVisible) {
                    HStack {
                        Spacer()
                        HStack(){
                            Icon(IconName.clock, 12)
                                .foregroundColor(Color.subText)
                            Text(String(format: "%.1f", secondsElapsed))
                                .small()
                                .foregroundColor(Color.subText)
                                .frame(width: 30)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                }
                
                if(isAnswerVisible) {
                    VStack(){
                        Icon(IconName.down, 12)
                            .foregroundColor(Color.white)
                            .padding(.vertical, 12)
                        Text(question.en)
                            .exLgBold()
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color.white)
                            .padding(.horizontal, 20)
                        
                        Spacer()
                        
                        Text("訳せた？")
                            .smallJaBold()
                            .foregroundColor(Color.white)
                        
                        HStack(spacing: 64){
                            Button(action: {
                                vm.handleInCorrect()
                            }){
                                Icon(IconName.x, 32)
                                    .foregroundColor(Color.white)
                                    .frame(width: 72, height: 72)
                                    .background(Color.lightBg)
                                    .cornerRadius(8)
                            }
                            
                            Button(action: {
                                vm.handleCorrect()
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
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
