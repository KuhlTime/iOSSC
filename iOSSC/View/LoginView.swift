//
//  LoginView.swift
//  iOSSC
//
//  Created by André Kuhlmann on 16.10.20.
//

import SwiftUI
import Haptica
import SFSafeSymbols

struct LoginView: View {
    @EnvironmentObject var manager: APIManager
    
    @State private var username = ""
    @State private var password = ""
    @State private var saveCredentials = false
    
    @State private var editUrl: Bool = false
    @State private var customUrl: String = ""
    
    var body: some View {
        ZStack {
            BackgroundView()
            
            HStack(alignment: .top) {
                Spacer()
                infoButton
            }
            .frame(maxHeight: .infinity, alignment: .topTrailing)
            .padding()
            
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
        manager.customUrl = customUrl.isEmpty ? nil : customUrl
        manager.login(username, password)
    }
    
    private var infoButton: some View {
        Button(action: {
            editUrl.toggle()
        }) {
            Image(systemName: "gearshape.fill")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(.white)
        }
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
            if (editUrl) {
                VStack {
                    Text("Nur HTTPS erlaubt!")
                        .foregroundColor(.white)
                    InputField(manager.baseUrl, text: $customUrl)
                }
                .padding(.bottom, 8)
            }
            
            InputField("Benutzername", text: $username)
                .padding(.bottom, 8)
            InputField("Password", text: $password, isSecure: true)
        }
    }
    
    private var footer: some View {
        VStack {
            Button("Login") {
                manager.login(username, password)
                Haptic.impact(.medium).generate()
            }
            .buttonStyle(
                BigButton(Color(hex: 0xE60028), Color(hex: 0xE60028).darker())
            )
            
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
