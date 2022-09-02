//
//  LoadingView.swift
//  Getit
//
//  Created by kaorulego5x on 2022/06/30.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack(){
            Spacer()
            HStack(){
                Spacer()
                Text("Loading...")
                    .getit()
                    .foregroundColor(Color.white)
                Spacer()
            }
            Spacer()
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
