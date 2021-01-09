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

// Future Reference:
// - https://medium.com/@rashidium/generic-api-response-handling-with-codable-in-swift-5-using-alamofire-5-9809522de87
// -  https://medium.com/@AladinWay/write-a-networking-layer-in-swift-4-using-alamofire-5-and-codable-part-3-using-futures-promises-cf3977fc8a5

class APIManager: ObservableObject {
    @Published var data: ResponseData?
    @Published var loginState: LoginState = .loggedOut
    
    private let environment: Environment
    private var username: String?
    private var password: String?
    
    /**
     The KeychainAccess reference object
     */
    private let keychain = Keychain(service: "me.kuhlti.iossc")
    
    init(enviorment: Environment = .production) {
        self.environment = enviorment
        
        autoLogin()
    }
    
    /**
     An array containing all available modules. If not signed in. The property will return an empty array.
     */
    var modules: [Module] {
        return data?.modules ?? []
    }
    
    var avgGrade: Grade? {
        return data?.avgGrade
    }
    
    var totalCreditPoints: Int? {
        return data?.totalCreditPoints
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
    
    var isRefreshing: Bool {
        return loginState == .refreshing
    }
    
    func login(_ username: String?, _ password: String?) {
        guard let username = username, let password = password else {
            return
        }
        
        loginState = .loggingIn
        
        self.username = username
        self.password = password
        
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
            
            if (username != nil && password != nil) {
                print("Restored credentials")
                login(username, password)
            }
        } catch {
            print(error.localizedDescription)
            return
        }
    }
    
    func refresh(completion: (() -> Void)? = nil) {
        loginState = .refreshing
        fetchModules(completion: { completion?() })
    }
    
    /**
    Fetches all available data for the provided username and password
    GET https://api.kuhlti.me/ossc/modules
     */
    private func fetchModules(completion: (() -> Void)? = nil) {
        guard let username = username, let password = password else {
            loginState = .error
            print("Can't fetch without username and password")
            completion?()
            return
        }
        
        AF.request(environment.url, method: .get, headers: getHeaders(username, password))
            .responseDecodable { (response: DataResponse<APIResponse<ResponseData>, AFError>) in
                if let error = response.error {
                    print(error.localizedDescription)
                    self.logout()
                    self.loginState = .error
                    completion?()
                    return
                }
                
                if let apiResponse = response.value {
                    switch apiResponse.status {
                    case .success:
                        guard let data = apiResponse.data else {
                            print("No data in APIResponse")
                            completion?()
                            return
                        }
                        
                        print("Recieved Data")
                        self.data = data
                        self.loginState = .loggedIn
                        
                        completion?()
                        
                    case .failed:
                        print("API error with message: \(apiResponse.message ?? "NO MESSAGE PROVIDED")")
                        self.logout()
                        self.loginState = .error
                        
                        completion?()
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
    
    /**
     Sets the environment the application should run in
     */
    enum Environment {
        /**
         In development mode the application requests a demo response in order to minimize traffic to the ossc server.
         */
        case development
        
        /**
         In production mode the user recieves its original data from the ossc's servers
         */
        case production
        
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
        case loggedOut, loggingIn, loggedIn, error, refreshing
    }
}
