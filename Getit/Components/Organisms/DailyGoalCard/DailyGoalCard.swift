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
                HStack(spacing: 24){
                    Text("Learn")
                        .lg()
                        .foregroundColor(.text)
                    Text("2 / 3")
                        .lgBold()
                        .foregroundColor(.text)
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                
                HStack(){
                    Text("Learn")
                        .lg()
                        .foregroundColor(.text)
                    Text("2 / 3")
                        .lgBold()
                        .foregroundColor(.text)
                }
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
