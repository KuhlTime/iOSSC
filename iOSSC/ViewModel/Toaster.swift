//
//  Toaster.swift
//  iOSSC
//
//  Created by André Kuhlmann on 26.10.20.
//

import SwiftUI

/**
 The Toaster handles the backing process.
 */
struct Toaster: View {
    var body: some View {
        VStack {
            Spacer()
            Text("Logged In")
                .foregroundColor(.white)
                .padding(.horizontal, 12)
                .padding(.vertical, 4)
                .background(BlurView(style: .systemThinMaterial).cornerRadius(6))
        }
    }
}

struct Toaster_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Image("Unsplash")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
            Toaster()
        }
    }
}
