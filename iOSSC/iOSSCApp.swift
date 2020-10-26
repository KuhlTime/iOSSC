//
//  iOSSCApp.swift
//  iOSSC
//
//  Created by André Kuhlmann on 16.10.20.
//

import SwiftUI
import Sentry

private let env: APIManager.Enviorment = .production

@main
struct iOSSCApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    @ObservedObject var manager = APIManager(enviorment: env)
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                if (manager.isLoggedIn || manager.isRefreshing) {
                    ContentView().environmentObject(manager)
                } else if (manager.isLoggingIn) {
                    LoadingScreen()
                } else {
                    LoginView().environmentObject(manager)
                }
                
                if (env == .development) {
                    VStack {
                        HStack {
                            Text("Development Mode")
                                .foregroundColor(.red)
                                .font(.caption)
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            Spacer()
                        }
                        .padding(.horizontal, 21)
                        .padding(.top, -4)
                        Spacer()
                    }
                }
            }
        }
    }
}
