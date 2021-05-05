//
//  iOSSCApp.swift
//  iOSSC
//
//  Created by André Kuhlmann on 16.10.20.
//

import SwiftUI

let env: APIManager.Environment = .production

@main
struct iOSSCApp: App {
    
    @ObservedObject
    private var manager = APIManager(enviorment: env)
    
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
                
                // Toaster
            
                
                // Development Label
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
