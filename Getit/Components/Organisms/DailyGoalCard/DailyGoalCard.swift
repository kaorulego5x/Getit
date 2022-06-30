//
//  DailyGoalCard.swift
//  Getit
//
//  Created by kaorulego5x on 2022/06/30.
//

import SwiftUI

struct DailyGoalCard: View {
    var body: some View {
        VStack(spacing: 16) {
            HStack(){
                HStack(){
                    Icon(.award, 14)
                        .foregroundColor(.subText)
                    Text("Daily Goal")
                        .exSmall()
                        .foregroundColor(.subText)
                }
                Spacer()
            }
            
            HStack(){
                HStack(){
                    Text("Learn")
                        .lg()
                        .foregroundColor(.text)
                    
                    Spacer()
                    
                    Text("2 / 3")
                        .lgBold()
                        .foregroundColor(.text)
                    
                    Spacer()
                }
                .padding(.trailing, 16)
                .frame(maxWidth: .infinity)
                
                HStack{}
                    .frame(width: 1, height:18)
                    .cornerRadius(1)
                    .background(Color.subText)
                
                HStack(){
                    Text("Use")
                        .lg()
                        .foregroundColor(.text)
                    
                    Spacer()
                    
                    Text("4 / 5")
                        .lgBold()
                        .foregroundColor(.text)
                    
                    Spacer()
                }
                .padding(.leading, 16)
                .frame(maxWidth: .infinity)
            }
        }
        .padding(16)
        .background(Color.boxBg)
        .cornerRadius(20)
    }
}

struct DailyGoalCard_Previews: PreviewProvider {
    static var previews: some View {
        DailyGoalCard()
    }
}
