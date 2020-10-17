//
//  LoadingScreen.swift
//  iOSSC
//
//  Created by André Kuhlmann on 17.10.20.
//

import SwiftUI

struct LoadingScreen: View {
    var body: some View {
        ZStack {
            BackgroundView()
            ProgressView()
        }
    }
}

struct LoadingScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoadingScreen()
    }
}
