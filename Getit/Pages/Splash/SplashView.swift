//
//  SplashView.swift
//  Geit
//
//  Created by kaorulego5x on 2021/12/14.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        VStack(){
            Spacer()
            HStack(){
                Spacer()
                Text("Getit")
                    .getit()
                    .foregroundColor(Color.white)
                Spacer()
            }
            Spacer()
        }
        .background(Color.bg.ignoresSafeArea())
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
