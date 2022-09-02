//
//  NextUpCard.swift
//  Getit
//
//  Created by kaorulego5x on 2022/06/30.
//

import SwiftUI

let UnitTypeText = [UnitType.single: "単体での使い方", UnitType.idiom: "イディオム", UnitType.practical: "定型表現"]

struct NextUpCard: View {
    let nextUp: NextUp?
    
    init(_ nextUp: NextUp?) {
        self.nextUp = nextUp
    }
    
    var body: some View {
        if let nextUp = nextUp {
            VStack(spacing: 0){
                HStack(){
                    VStack(alignment: .leading, spacing: 15){
                        HStack(spacing: 8){
                            Icon(IconName.next, 12)
                                .foregroundColor(Color.subText)
                            
                            Text("Next up")
                                .exSmall()
                                .foregroundColor(Color.subText)
                        }
                        
                        HStack(alignment: .bottom){
                            Text(nextUp.word.firstUppercased)
                                .exLgBold()
                                .foregroundColor(Color.white)
                            
                            HStack(alignment: .bottom, spacing: 3){
                                Text("#\(nextUp.index+1)")
                                    .exLgBold()
                                    .foregroundColor(Color.white)
                                
                                Text("/ \(nextUp.unitNum)")
                                    .exSmallBold()
                                    .foregroundColor(Color.white)
                                    .padding(.bottom, 2)
                            }
                            
                            Text(UnitTypeText[nextUp.type] ?? "")
                                .mainJa()
                                .foregroundColor(Color.white)
                        }
                    }
                    
                    Spacer()
                    
                    Icon(IconName.right, 24)
                        .foregroundColor(Color.white)
                }
                .padding(18)
                .background(Color.darkBg)
                .cornerRadius(8)
                
                Triangle()
                    .fill(Color.darkBg)
                    .frame(width: 36, height: 24)
                    .rotationEffect(Angle(degrees: 180))
            }
        }
    }
}


struct NextUpCard_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
