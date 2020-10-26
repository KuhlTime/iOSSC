//
//  iOSSCApp.swift
//  iOSSC
//
//  Created by André Kuhlmann on 16.10.20.
//

import SwiftUI
import Sentry

@main
struct iOSSCApp: App {
    @ObservedObject var manager = APIManager(enviorment: .production)
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
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
