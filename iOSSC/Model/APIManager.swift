//
//  APIManager.swift
//  iOSSC
//
//  Created by André Kuhlmann on 16.10.20.
//

import Foundation
import Combine
import Alamofire
import KeychainAccess
import SwiftyUserDefaults

// Future Reference:
// - https://medium.com/@rashidium/generic-api-response-handling-with-codable-in-swift-5-using-alamofire-5-9809522de87
// -  https://medium.com/@AladinWay/write-a-networking-layer-in-swift-4-using-alamofire-5-and-codable-part-3-using-futures-promises-cf3977fc8a5

class APIManager: ObservableObject {
    @Published var data: ResponseData?
    @Published var loginState: LoginState = .loggedOut
    
    private let enviorment: Enviorment
    private var username: String?
    private var password: String?
    
    /**
     The KeychainAccess reference object
     */
    private let keychain = Keychain(service: "me.kuhlti.iossc")
    
    init(enviorment: Enviorment = .production) {
        self.enviorment = enviorment
        
        autoLogin()
    }
    
    /**
     An array containing all available modules. If not signed in. The property will return an empty array.
     */
    var modules: [Module] {
        return data?.modules ?? []
    }
    
    /**
     Returns whether the user is currently logged in
     */
    var isLoggedIn: Bool {
        // Check for stored credentials
        // guard let username = username, let password = password else { return false }
        // return !username.isEmpty && !password.isEmpty && data != nil
        return loginState == .loggedIn
    }
    
    var isLoggingIn: Bool {
        return loginState == .loggingIn
    }
    
    func login(_ username: String?, _ password: String?) {
        guard let username = username, let password = password else {
            return
        }
        
        self.username = username
        self.password = password
        
        loginState = .loggingIn
        
        do {
            try keychain.set(username, key: "username")
            try keychain.set(password, key: "password")
            
            print("Saved credentials")
        } catch {
            print("Error while setting keychain: \(error.localizedDescription)")
            loginState = .error
            return
        }
        
        fetchModules()
    }
    
    func logout() {
        do {
            try keychain.remove("username")
            try keychain.remove("password")
            
            print("Removed credentials")
        } catch {
            print("Could not delete Keychain items: \(error.localizedDescription)")
        }
        
        username = nil
        password = nil
        
        loginState = .loggedOut
    }
    
    func autoLogin() {
        do {
            username = try keychain.get("username")
            password = try keychain.get("password")
            
            print("Restored credentials")
            
            login(username, password)
        } catch {
            print(error.localizedDescription)
            return
        }
    }
    
    /**
    Fetches all available data for the provided username and password
    GET https://api.kuhlti.me/ossc/modules
     */
    private func fetchModules() {
        guard let username = username, let password = password else {
            loginState = .error
            print("Can't fetch without username and password")
            return
        }
        
        AF.request(enviorment.url, method: .get, headers: getHeaders(username, password))
            .responseDecodable { (response: DataResponse<APIResponse<ResponseData>, AFError>) in
                if let error = response.error {
                    print(error.localizedDescription)
                    self.logout()
                    self.loginState = .error
                    return
                }
                
                if let apiResponse = response.value {
                    switch apiResponse.status {
                    case .success:
                        guard let data = apiResponse.data else {
                            print("No data in APIResponse")
                            return
                        }
                        
                        print("Recieved Data")
                        self.data = data
                        self.loginState = .loggedIn
                        
                    case .failed:
                        print("API error with message: \(apiResponse.message ?? "NO MESSAGE PROVIDED")")
                        self.logout()
                        self.loginState = .error
                    }
                }
            }
    }
    
    private func getHeaders(_ username: String, _ password: String) -> HTTPHeaders {
        let credentialData = "\(username):\(password)".data(using: .utf8)
        guard let cred = credentialData else { return ["" : ""] }
        
        let base64Credentials = cred.base64EncodedData(options: [])
        guard let base64Date = Data(base64Encoded: base64Credentials) else { return ["" : ""] }
        
        return ["Authorization": "Basic \(base64Date.base64EncodedString())"]
    }
    
    enum Enviorment {
        case development, production
        
        var url: String {
            switch self {
            case .development:
                return "https://api.kuhlti.me/ossc/test"
            case .production:
                return "https://api.kuhlti.me/ossc/modules"
            }
        }
    }
    
    enum LoginState {
        case loggedOut, loggingIn, loggedIn, error
    }
}
