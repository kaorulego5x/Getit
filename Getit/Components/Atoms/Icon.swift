//
//  Icon.swift
//  Getit
//
//  Created by kaorulego5x on 2022/06/30.
//

import SwiftUI

enum IconName: String {
    case award = "award"
    case right = "chevron-right"
    case help = "help"
    case play = "play"
    case replay = "replay"
    case progress = "progress"
    case tag = "tag"
    case zap = "zap"
    case x = "x"
}

struct Icon: View {
    var name: String
    var size: CGFloat
        
    init(_ name: IconName, _ size:CGFloat){
        self.name = name.rawValue
        self.size = size
    }
        
    var body: some View {
        Image(name)
            .resizable()
            .renderingMode(.template)
            .aspectRatio(contentMode: .fit)
            .frame(width:size, height:size)
    }
}
