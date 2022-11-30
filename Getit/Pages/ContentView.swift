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
                    HomeView(eo: self.eo)
                } else if(eo.tab == .activity) {
                    ActivityView(eo: self.eo)
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

extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}

extension StringProtocol {
    var firstUppercased: String { prefix(1).uppercased() + dropFirst() }
    var firstCapitalized: String { prefix(1).capitalized + dropFirst() }
}

func matches(for regex: String, in text: String) -> [String] {

    do {
        let regex = try NSRegularExpression(pattern: regex)
        let results = regex.matches(in: text,
                                    range: NSRange(text.startIndex..., in: text))
        return results.map {
            String(text[Range($0.range, in: text)!])
        }
    } catch let error {
        print("invalid regex: \(error.localizedDescription)")
        return []
    }
}

extension String {
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }

    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return String(self[fromIndex...])
    }

    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return String(self[..<toIndex])
    }

    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return String(self[startIndex..<endIndex])
    }
}
