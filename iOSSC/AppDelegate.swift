//
//  AppDelegate.swift
//  iOSSC
//
//  Created by André Kuhlmann on 19.10.20.
//

import UIKit
import Sentry

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        SentrySDK.start { (options) in
            options.dsn = "https://a15a2ce49b0645c6973d37f861f2b423@o459771.ingest.sentry.io/5469457"
            options.debug = true
        }
        
        return true
    }
}
