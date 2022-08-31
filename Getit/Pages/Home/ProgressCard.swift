//
//  ProgressCard.swift
//  Getit
//
//  Created by kaorulego5x on 2022/06/30.
//

import SwiftUI

struct ProgressCard: View {
    var body: some View {
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
    }
}

struct ProgressCard_Previews: PreviewProvider {
    static var previews: some View {
        ProgressCard()
    }
}
