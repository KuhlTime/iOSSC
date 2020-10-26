//
//  BackgroundView.swift
//  iOSSC
//
//  Created by André Kuhlmann on 17.10.20.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        LinearGradient(gradient: backgroundGradient, startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
    }
    
    var backgroundGradient: Gradient {
        return Gradient(stops: [.init(color: Color(#colorLiteral(red: 0.13725490868091583, green: 0.1764705926179886, blue: 0.25882354378700256, alpha: 1)), location: 0), .init(color: Color(#colorLiteral(red: 0.06046874821186066, green: 0.07725301384925842, blue: 0.11249999701976776, alpha: 1)), location: 1)])
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
    }
}
