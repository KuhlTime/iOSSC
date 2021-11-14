//
//  LoadingScreen.swift
//  iOSSC
//
//  Created by André Kuhlmann on 17.10.20.
//

import SwiftUI
import SFSafeSymbols

struct LoadingScreen: View {
    @State private var showText = false
    
    var body: some View {
        ZStack {
            BackgroundView()
            VStack {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                    .padding()
                HStack {
                    Image(systemSymbol: .boltHorizontalCircleFill)
                    Text(randomLoadingMessage)
                        .multilineTextAlignment(.center)
                }
                .opacity(showText ? 1 : 0)
            }
            .foregroundColor(.white)
        }
        .onAppear {
            withAnimation(Animation.easeIn(duration: 1).delay(3)) {
                showText = true
            }
        }
    }
    
    var randomLoadingMessage: String {
        let el: String! = [
            "Starte den Server.",
            "Hacke das OSSC.",
            "Jetzt heißt es warten.",
            "Bip Bup Bip...",
            "Zähle bis 10.",
            "Teile durch 0.",
            "Du Streber.",
            "Wärme das Internet auf.",
            "Beame Daten."
        ].randomElement()
        
        return el
    }
}

struct LoadingScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoadingScreen()
    }
}
