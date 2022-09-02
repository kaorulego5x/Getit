//
//  ContentView.swift
//  Getit
//
//  Created by kaorulego5x on 2021/11/27.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var eo: AppViewModel
    
    var body: some View{
        
        ZStack(){
            if(eo.loaded) {
                if(eo.tab == .home) {
                    HomeView(vm: HomeViewModel(eo: self.eo))
                } else if(eo.tab == .activity) {
                    ActivityView()
                } else if(eo.tab == .loading) {
                    LoadingView()
                }
            }
            
            SplashView()
                .opacity(eo.loaded ? 0 : 1)
        }
        .background(Color.bg.ignoresSafeArea())
        .onAppear(){
            eo.handleLaunch()
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
    static let lightBg = Color("lightBg")
    static let darkBg = Color("darkBg")
    static let text = Color("text")
    static let subText = Color("subText")
    static let learnGrad = Gradient(colors: [Color("learn1"), Color("learn2")])
    static let learn1 = Color("learn1")
    static let learn2 = Color("learn2")
    static let useGrad = Gradient(colors: [Color("use1"), Color("use2")])
    static let undone = Color("undone")
}

public extension Text {
    func bullet() -> some View {
        self.font(.custom("Montserrat-Bold", size:48))
    }

    func getit() -> some View {
        self.font(.custom("Montserrat-Bold", size:32))
    }

    func lookup() -> some View {
        self.font(.custom("Montserrat-Bold", size: 30))
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
    
    func small() -> some View {
        self.font(.custom("Montserrat-Medium", size:14))
    }
    
    func smallJa() -> some View {
        self.font(.custom("NotoSansJP-Medium", size:14))
    }
    
    func smallJaBold() -> some View {
        self.font(.custom("NotoSansJP-Bold", size:14))
    }
    
    func exSmall() -> some View {
        self.font(.custom("Montserrat-Medium", size:12))
    }
    
    func exSmallBold() -> some View {
        self.font(.custom("Montserrat-Bold", size:12))
    }
    
    func exSmallJa() -> some View {
        self.font(.custom("NotoSansJP-Medium", size:12))
    }
    
    func exSmallJaBold() -> some View {
        self.font(.custom("NotoSansJP-Bold", size:12))
    }
}

extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}

extension StringProtocol {
    var firstUppercased: String { prefix(1).uppercased() + dropFirst() }
    var firstCapitalized: String { prefix(1).capitalized + dropFirst() }
}
