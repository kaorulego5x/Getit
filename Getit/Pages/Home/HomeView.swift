//
//  HomeView.swift
//  Getit
//
//  Created by Kaoru Nishihara on 2021/11/28.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var eo: AppViewModel
    @StateObject var vm: HomeViewModel
    
    init(eo: AppViewModel){
        _vm = StateObject(wrappedValue: HomeViewModel(eo: eo))
    }
    
    var body: some View {
        NavigationView(){
            VStack(spacing: 0){
                ZStack(){
                    Text("Getit")
                        .getit()
                        .foregroundColor(.text)
                    
                    HStack(){
                        Spacer()
                        Icon(.help, 20)
                            .foregroundColor(.subText)
                    }
                    .padding(.horizontal, 20)
                }
                .padding(.top, 24)
                .padding(.bottom, 48)
                
                ZStack(){
                    Circle()
                        .fill(Color.darkBg)
                        .frame(width:218, height: 218)
                    
                    VStack(alignment: .leading, spacing: 20){
                        HStack(spacing: 8){
                            HStack { }
                            .frame(width: 18, height: 18)
                            .background(LinearGradient(gradient: Color.learnGrad, startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(7)
                            
                            Text("習得済み")
                                .smallJaBold()
                                .foregroundColor(Color.white)
                                .frame(width: 64, alignment: .leading)
                            
                            Text(String(vm.user.questionNum))
                                .mainBold()
                                .foregroundColor(Color.white)
                        }
                       
                        HStack(spacing: 8){
                            HStack { }
                            .frame(width: 18, height: 18)
                            .background(Color.lightBg)
                            .cornerRadius(7)
                            
                            Text("未習得")
                                .smallJaBold()
                                .foregroundColor(Color.white)
                                .frame(width: 64, alignment: .leading)
                            
                            Text(String(vm.masterData.totalQuestionNum))
                                .mainBold()
                                .foregroundColor(Color.white)
                        }
                    }
                    
                    ZStack {
                        Circle()
                            .stroke(Color.lightBg, lineWidth: 32)
                            .frame(width:234, height: 234)
                            
                        Circle()
                            .trim(from: 0, to: vm.progressRate)
                            .stroke(
                                AngularGradient(
                                    gradient: Color.learnGrad,
                                    center: .center,
                                    startAngle: .degrees(0),
                                    endAngle: .degrees(360)
                                ),
                                style: StrokeStyle(lineWidth: 32, lineCap: .round)
                            )
                            .rotationEffect(.degrees(-90))
                            .frame(width:234, height: 234)
                        Circle()
                            .frame(width: 32, height: 32)
                            .foregroundColor(Color.learn1)
                            .offset(y: -117)
                        Circle()
                            .frame(width: 32, height: 32)
                            .foregroundColor(vm.progressRate > 0.95 ? Color.learn2: Color.learn1.opacity(0))
                            .offset(y: -117)
                            .rotationEffect(Angle.degrees(360 * Double(vm.progressRate)))
                            .shadow(color: vm.progressRate > 0.96 ? Color.black.opacity(0.1): Color.clear, radius: 3, x: 4, y: 0)
                    }
                    .frame(idealWidth: 300, idealHeight: 300, alignment: .center)
                }
                .padding(.top, 16)
                
                Spacer()
                
                NavigationLink(destination: MapView(eo: self.eo)){
                    NextUpCard(vm.nextUp)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 30)
                
                Button(action:{
                    self.vm.transitToActivity()
                }){
                    HStack(spacing:0){
                        Text("学習を始める")
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
                .padding(.bottom, 48)
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .background(Color.bg.ignoresSafeArea())
        }
        .accentColor(Color.subText)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
