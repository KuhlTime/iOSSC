//
//  LoginView.swift
//  iOSSC
//
//  Created by André Kuhlmann on 16.10.20.
//

import SwiftUI
import Haptica

struct LoginView: View {
    @EnvironmentObject var manager: APIManager
    
    @State private var username = ""
    @State private var password = ""
    @State private var saveCredentials = false
    
    var body: some View {
        ZStack {
            BackgroundView()
            Group {
                VStack {
                    Text("iOSSC").font(.custom("HSD Sans", size: 28)).fontWeight(.heavy).foregroundColor(Color(#colorLiteral(red: 0.9019607843, green: 0, blue: 0.1568627451, alpha: 1)))
                    Text("by André Kuhlmann").font(.caption).foregroundColor(.gray).padding(.bottom)
                    
                    Group {
                        TextField("", text: $username)
                            .keyboardType(.default)
                            .placeHolder(Text("Username").foregroundColor(.gray), show: username.isEmpty)
                        SecureField("", text: $password)
                            .placeHolder(Text("Password").foregroundColor(.gray), show: password.isEmpty)
                        // Toggle("Save Credentials", isOn: $saveCredentials).padding(.vertical)
                    }
                    .disabled(manager.isLoggingIn)
                    .foregroundColor(.black)
                    .padding(.bottom)
                    
                    Button("Login") {
                        login()
                    }
                    .disabled(manager.isLoggingIn)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(Color(#colorLiteral(red: 0.9019607843, green: 0, blue: 0.1568627451, alpha: 1)))
                    .cornerRadius(6)
                    .onTapGesture {
                        login()
                    }
                }
                .padding()
            }
            .background(Color.white)
            .cornerRadius(14)
            .padding(30)
        }
    }
    
    private func login() {
        guard !username.isEmpty && !password.isEmpty else { return }
        
        Haptic.impact(.medium).generate()
        manager.login(username, password)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
