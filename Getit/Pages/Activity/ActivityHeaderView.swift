//
//  ActivityView.swift
//  Getit
//
//  Created by kaorulego5x on 2022/06/30.
//

import SwiftUI

struct ActivityHeaderView: View {
    var type: ActivityType
    var title: String;
    var currentQuestionIndex: Int;
    var questionNum: Int;
    
    @State private var totalHeight = CGFloat(100)
    
    var body: some View {
        let completeRate = CGFloat(currentQuestionIndex + 1) / CGFloat(questionNum)
        VStack(spacing: 4){
            HStack(){
                Text(title)
                    .main()
                    .foregroundColor(Color.subText)
                Spacer()
            }
            
            HStack(){
                GeometryReader {
                    geometry in
                    ZStack(alignment:.leading){
                        HStack{}
                            .frame(height: 12)
                            .frame(maxWidth: geometry.size.width)
                            .background(GeometryReader {gp -> Color in
                                DispatchQueue.main.async {
                                    self.totalHeight = gp.size.height
                                }
                                return Color.undone})
                            .cornerRadius(4)
                        
                        HStack(){}
                            .frame(height: 12)
                            .frame(maxWidth: geometry.size.width * completeRate)
                            .background(LinearGradient(gradient: (type == ActivityType.learn ? Color.learnGrad : Color.useGrad), startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(4)
                    }
                }
                .frame(height: totalHeight)
                
                Icon(IconName.x, 18)
                    .foregroundColor(Color.subText)
            }
            
        }
        
    }
}

struct ActivityFrameView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityHeaderView(type: .learn, title: "Get Idiom Pt.2", currentQuestionIndex: 3, questionNum: 8)
            .background(Color.bg)
    }
}
