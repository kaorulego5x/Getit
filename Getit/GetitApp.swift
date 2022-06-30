//
//  GetitApp.swift
//  Getit
//
//  Created by kaorulego5x on 2022/06/30.
//

import SwiftUI

@main
struct GetitApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(GlobalStore())
        }
    }
}
