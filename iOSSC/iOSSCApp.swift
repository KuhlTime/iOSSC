//
//  iOSSCApp.swift
//  iOSSC
//
//  Created by André Kuhlmann on 16.10.20.
//

import SwiftUI

@main
struct iOSSCApp: App {
    @ObservedObject var manager = APIManager(enviorment: .production)
    
    var body: some Scene {
        WindowGroup {
            if (manager.isLoggedIn || manager.isRefreshing) {
                ContentView().environmentObject(manager)
            } else if (manager.isLoggingIn) {
                LoadingScreen()
            } else {
                LoginView().environmentObject(manager)
            }
        }
    }
}
