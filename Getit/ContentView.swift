//
//  ContentView.swift
//  Getit
//
//  Created by kaorulego5x on 2021/11/27.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var store: GlobalStore
    
    var body: some View{
        ZStack(){
            if(store.loaded){
                if(store.tab == .home){
                    HomeView()
                } else if(store.tab == .activity) {
                    ActivityView()
                } else if(store.tab == .loading){
                    LoadingView()
                }
            }
            
            SplashView()
                .opacity(store.loaded ? 0 : 1)
        }
        .onAppear(){
            store.handleLaunch()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


extension Color {
    static let bg = Color("bg")
    static let boxbg = Color("boxBg")
    static let text = Color("text")
    static let subtext = Color("subtext")
    static let pink = Gradient(colors: [Color("pink1"), Color("pink2")])
    static let purple = Gradient(colors: [Color("purple1"), Color("purple2")])
}

public extension Text {
    func title() -> some View {
        self.font(.custom("Montserrat-Bold", size:32))
    }
    
    func boxtitle() -> some View {
        self.font(.custom("Montserrat-Medium", size:12))
    }
    
    func message() -> some View {
        self.font(.custom("Montserrat-ExtraBold", size: 24))
    }
    
    func menuDesc() -> some View {
        self.font(.custom("Montserrat-Medium", size:14))
    }
    
    func subText() -> some View {
        self.font(.custom("Montserrat-Medium", size:17))
            .foregroundColor(.subtext)
    }
    
    func listenText() -> some View {
        self.font(.custom("NotoSansJP-Bold", size:24))
            .foregroundColor(.text)
    }
    
    func requestText() -> some View {
        self.font(.custom("NotoSansJP-Medium", size:17))
            .foregroundColor(.subtext)
    }
    
    func responseText() -> some View {
        self.font(.custom("Montserrat-Bold", size:24))
            .foregroundColor(.text)
    }
}
