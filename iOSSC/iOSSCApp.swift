//
//  iOSSCApp.swift
//  iOSSC
//
//  Created by André Kuhlmann on 16.10.20.
//

import SwiftUI
import SFSafeSymbols

@main
struct iOSSCApp: App {
    
    @ObservedObject
    private var manager = APIManager(enviorment: .production)
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                if (manager.isLoggedIn || manager.isRefreshing) {
                    ContentView()
                        .environmentObject(manager)
                } else if (manager.isLoggingIn) {
                    LoadingScreen()
                } else {
                    LoginView()
                        .environmentObject(manager)
                }
                
                // Development Label
                if (manager.inDevelopment) {
                    VStack {
                        HStack {
                            Spacer()
                            Text("Development Mode")
                                .foregroundColor(.red)
                                .font(.caption)
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
