//
//  MapView.swift
//  Getit
//
//  Created by kaorulego5x on 2022/09/01.
//

import SwiftUI

var wordList = ["Get"]
var activityList = [1, 2, 3, 4]

struct MapView: View {
    var body: some View {
        VStack() {
            ForEach(wordList, id: \.self) { word in
                DisclosureGroup(
                    content: {
                        VStack{
                            ForEach(activityList, id: \.self){ activity in
                                HStack(spacing: 10){
                                    HStack {
                                        Text(String(activity))
                                            .mainBold()
                                            .foregroundColor(Color.white)
                                    }
                                    .frame(width: 32, height: 32)
                                    .background(LinearGradient(gradient: Color.learnGrad, startPoint: .leading, endPoint: .trailing))
                                    .cornerRadius(12)
                                    
                                    Text("よく使う表現")
                                        .smallJaBold()
                                        .foregroundColor(Color.white)
                                    
                                    Spacer()
                                    
                                    Button(action: {}){
                                        Icon(IconName.replay, 16)
                                            .foregroundColor(Color.subText)
                                            .padding(8)
                                    }
                                }
                                .padding(.vertical, 8)
                            }
                        }
                    },
                    label:{
                        HStack(){
                            Text(word)
                                .lookup()
                                .foregroundColor(Color.white)
                            
                            Spacer()
                            
                            VStack(alignment: .leading, spacing: 6){
                                Text("50% (5/10)")
                                    .small()
                                    .foregroundColor(Color.subText)
                                
                                ZStack(alignment: .leading){
                                    HStack {}
                                    .frame(width: 108, height:8)
                                    .background(Color.lightBg)
                                    .cornerRadius(2)
                                    
                                    HStack {}
                                    .frame(width: 64, height:8)
                                    .background(LinearGradient(gradient: Color.learnGrad, startPoint: .leading, endPoint: .trailing))
                                    .cornerRadius(2)
                                }
                                .padding(.trailing, 12)
                            }
                        }
                        .padding(.vertical, 12)
                    }
                )
                .accentColor(Color.subText)
                .padding(.horizontal, 20)
            }
            Spacer()
        }
        .background(Color.bg.ignoresSafeArea())
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
