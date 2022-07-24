//
//  HomeView.swift
//  Getit
//
//  Created by Kaoru Nishihara on 2021/11/28.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var store: GlobalStore
    @StateObject var vm = HomeViewModel()
    
    var body: some View {
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
            
            ProgressCard()
                .padding(.horizontal, 20)
                .padding(.bottom, 24)
            
            DailyGoalCard()
                .padding(.horizontal, 20)
                .padding(.bottom, 24)
            
            NextUpCard()
                .padding(.horizontal, 20)
                .padding(.bottom, 12)
            
            HStack(spacing: 24){
                Button(action:{
                    print("pressed learn button!")
                }){
                    Text("Learn")
                        .exLgBold()
                        .foregroundColor(.text)
                        .frame(maxWidth:.infinity)
                        .frame(height: 72)
                        .background(LinearGradient(gradient: Color.learnGrad, startPoint: .top, endPoint: .bottom))
                        .cornerRadius(20)
                }
                
                Button(action:{
                    print("pressed use button!")
                }){
                    Text("Use")
                        .exLgBold()
                        .foregroundColor(.text)
                        .frame(maxWidth:.infinity)
                        .frame(height: 72)
                        .background(LinearGradient(gradient: Color.useGrad, startPoint: .top, endPoint: .bottom))
                        .cornerRadius(20)
                }
                
            }
            .padding(.horizontal, 20)
            
            
            Spacer()
        }
        .background(Color.bg.ignoresSafeArea())
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
