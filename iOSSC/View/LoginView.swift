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
            
            VStack(alignment: .leading) {
                header
                inputs
                    .padding(.top, 42)
                Spacer()
                footer
            }
            .padding(.horizontal, 32)
            .padding(.top, 88)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
    }
    
    private func login() {
        guard !username.isEmpty && !password.isEmpty else { return }
        
        Haptic.impact(.medium).generate()
        manager.login(username, password)
    }
    
    private var header: some View {
        VStack(alignment: .leading) {
            Text("IOSSC")
                .font(.custom("HSD Sans", size: 38))
                .foregroundColor(Color(hex: 0xE60028))
            
            Text("Melde dich mit deinem OSSC Account an.")
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(.white)
                .multilineTextAlignment(.leading)
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
    }
    
    private var inputs: some View {
        VStack {
            InputField("Benutzername", text: $username)
            InputField("Password", text: $password, isSecure: true)
                .padding(.top, 8)
        }
    }
    
    private var footer: some View {
        VStack {
            Button("Login", action: login)
                .frame(height: 47)
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
                .background(Rectangle().foregroundColor(Color(hex: 0xE60028)))
                .cornerRadius(5)
            
            Text("© 2021 André Kuhlmann")
                .ignoresSafeArea()
                .foregroundColor(.white)
                .padding(.vertical)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
