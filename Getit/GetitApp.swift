//
//  GetitApp.swift
//  Getit
//
//  Created by kaorulego5x on 2022/06/30.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift

class FirebaseManager :NSObject {
    let auth: Auth
    let db: Firestore
    
    static let shared = FirebaseManager()
    
    override init() {
        
        self.auth = Auth.auth()
        self.db = Firestore.firestore()
        
        super.init()
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        return true
    }
}

@main
struct GetitApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(AppViewModel())
        }
    }
}
