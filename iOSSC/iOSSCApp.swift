//
//  iOSSCApp.swift
//  iOSSC
//
//  Created by André Kuhlmann on 16.10.20.
//

import SwiftUI
import SFSafeSymbols
import Sentry

@main
struct iOSSCApp: App {
    
    @ObservedObject
    private var manager = APIManager(enviorment: .production)
    
    init() {
        SentrySDK.start { options in
            // Set the SENTRY_DSN inside your Schema
            options.dsn = ProcessInfo.processInfo.environment["SENTRY_DSN"]
            
            options.debug = true // Enabled debug when first installing is always helpful

            // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
            // We recommend adjusting this value in production.
            options.tracesSampleRate = 1.0
        }
    }
    
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
