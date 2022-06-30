//
//  NextUpCard.swift
//  Getit
//
//  Created by kaorulego5x on 2022/06/30.
//

import SwiftUI

struct NextUpCard: View {
    var body: some View {
        VStack(spacing: 0){
            VStack(spacing: 20){
                HStack(){
                    VStack(){
                        HStack(){
                            HStack(){
                                Icon(.zap, 14)
                                    .foregroundColor(.subText)
                                Text("Next up")
                                    .exSmall()
                                    .foregroundColor(.subText)
                            }
                            Spacer()
                        }
                        
                        HStack(alignment: .bottom, spacing: 4){
                            Text("Get #6")
                                .exLgBold()
                                .foregroundColor(.text)
                            Text("/ 10")
                                .mainBold()
                                .foregroundColor(.text)
                                .offset(y: -1)
                            Spacer()
                        }
                    }
                    
                    Icon(.right, 14)
                        .foregroundColor(.subText)
                }
            }
            .padding(16)
            .background(Color.boxBg)
            .cornerRadius(20)
            
            Triangle()
                .fill(Color.boxBg)
                .frame(width:36, height: 24)
                .rotationEffect(Angle(degrees: 180))
                .offset(x: -12-(UIScreen.screenWidth-40-24)/4)
        }
    }
}


struct NextUpCard_Previews: PreviewProvider {
    static var previews: some View {
        NextUpCard()
    }
}
