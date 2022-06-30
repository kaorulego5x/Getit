//
//  GlobalStore.swift
//  Getit
//
//  Created by kaorulego5x on 2022/06/30.
//

import Foundation

enum Tab {
    case home
    case loading
    case activity
}

class GlobalStore: ObservableObject {
    @Published var tab: Tab = Tab.home
    @Published var loaded: Bool = false
    
    func handleLaunch() -> Void {
        print("Hello World")
    }
}
