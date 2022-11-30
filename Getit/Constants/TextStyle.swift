//
//  TextStyle.swift
//  Getit
//
//  Created by kaorulego5x on 30/11/22.
//

import Foundation
import SwiftUI

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
    
    func lgJa() -> some View {
        self.font(.custom("NotoSansJP-Medium", size: 18))
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
    
    func mainJaBold() -> some View {
        self.font(.custom("NotoSansJP-Bold", size: 16))
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
    
    func smallBold() -> some View {
        self.font(.custom("Montserrat-SemiBold", size: 14))
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
