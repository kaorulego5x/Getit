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
    static let boxBg = Color("boxBg")
    static let text = Color("text")
    static let subText = Color("subText")
    static let learnGrad = Gradient(colors: [Color("learn1"), Color("learn2")])
    static let useGrad = Gradient(colors: [Color("use1"), Color("use2")])
}

public extension Text {
    func bullet() -> some View {
        self.font(.custom("Montserrat-Bold", size:48))
    }
    
    func getit() -> some View {
        self.font(.custom("Montserrat-Bold", size:32))
    }
    
    func exLgBold() -> some View {
        self.font(.custom("Montserrat-Bold", size: 20))
    }
    
    func exLg() -> some View {
        self.font(.custom("Montserrat-Medium", size: 20))
    }
    
    func lgBold() -> some View {
        self.font(.custom("Montserrat-Bold", size: 18))
    }
    
    func lg() -> some View {
        self.font(.custom("Montserrat-Medium", size: 18))
    }
    
    func mainBold() -> some View {
        self.font(.custom("Montserrat-SemiBold", size: 16))
    }
    
    func main() -> some View {
        self.font(.custom("Montserrat-Medium", size: 16))
    }
    
    func mainJa() -> some View {
        self.font(.custom("NotoSansJP-Medium", size: 16))
    }
    
    func exSmall() -> some View {
        self.font(.custom("Montserrat-Medium", size:12))
    }
}

extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}
