//
//  HomeView.swift
//  Geit
//
//  Created by Kaoru Nishihara on 2021/11/28.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var store: GlobalStore
    @StateObject var vm = HomeViewModel()
    
    var body: some View {
        VStack(){
            ZStack(){
                Text("Getit")
                    .getit()
                    .foregroundColor(.text)
                
                HStack(){
                    Spacer()
                    Icon(.award, 20)
                        .foregroundColor(.subText)
                }
                .padding(.horizontal, 20)
            }
            .padding(.top, 24)
            
            Spacer()
            
            VStack(spacing: 16){
                HStack(){
                    HStack(){
                        Icon(.progress, 14)
                            .foregroundColor(.subText)
                        Text("Progress")
                            .exSmall()
                            .foregroundColor(.subText)
                    }
                    Spacer()
                }
                ZStack(alignment: .leading){
                    HStack(){}
                        .frame(height:18)
                        .frame(maxWidth: .infinity)
                        .background(Color.bg)
                        .cornerRadius(7)
                    HStack(){}
                        .frame(width: 120, height:18)
                        .background(LinearGradient(gradient: Color.learnGrad, startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(7)
                    HStack(){}
                        .frame(width: 60, height:18)
                        .background(LinearGradient(gradient: Color.useGrad, startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(7)
                }
                HStack(spacing: 24){
                    HStack(spacing: 8){
                        HStack{}
                            .frame(width:18, height:18)
                            .background(LinearGradient(gradient: Color.useGrad, startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(7)
                        Text("120")
                            .mainBold()
                            .foregroundColor(.text)
                    }
                    
                    HStack(spacing: 8){
                        HStack{}
                            .frame(width:18, height:18)
                            .background(LinearGradient(gradient: Color.learnGrad, startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(7)
                        Text("90")
                            .mainBold()
                            .foregroundColor(.text)
                    }
                    
                    HStack(spacing: 8){
                        HStack{}
                            .frame(width:18, height:18)
                            .background(Color.bg)
                            .cornerRadius(7)
                        Text("60")
                            .mainBold()
                            .foregroundColor(.text)
                    }
                    
                    Spacer()
                }
            }
            .padding(16)
            .background(Color.boxBg)
            .cornerRadius(20)
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
