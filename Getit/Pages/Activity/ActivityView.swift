//
//  ActivityView.swift
//  Getit
//
//  Created by kaorulego5x on 2022/07/28.
//

import SwiftUI

struct ActivityView: View {
    var body: some View {
        VStack(){
            ActivityHeaderView(type: ActivityType.use, title: "Get Idiom Pt.1", currentQuestionIndex: 5, questionNum: 10)
        }
        .background(Color.bg)
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView()
    }
}
