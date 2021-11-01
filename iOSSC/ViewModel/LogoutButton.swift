//
//  LogoutButton.swift
//  iOSSC
//
//  Created by André Kuhlmann on 01.11.21.
//

import SwiftUI

struct LogoutButton: View {
    @State var action: () -> ()
    
    var body: some View {
        Button("Logout") {
            self.action()
        }
        .multilineTextAlignment(.center)
        .foregroundColor(.black)
        .background(
            Capsule()
                .padding(.horizontal, -12)
                .padding(.vertical, -4)
                .foregroundColor(.white)
        )
    }
}

struct LogoutButton_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Rectangle()
            LogoutButton(action: {
                print("Pressed")
            })
        }
        .previewLayout(
            .fixed(width: 200, height: 100)
        )
    }
}
