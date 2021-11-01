//
//  BigButton.swift
//  iOSSC
//
//  Created by André Kuhlmann on 01.11.21.
//

import SwiftUI

struct BigButton: ButtonStyle {
    @State var backgroundColor: Color
    @State var pressedBackgroundColor: Color
    @State var textColor: Color
    
    init(_ backgroundColor: Color, _ pressedBackgroundColor: Color, _ textColor: Color = .white) {
        self.backgroundColor = backgroundColor
        self.pressedBackgroundColor = pressedBackgroundColor
        self.textColor = textColor
    }
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .font(.system(size: 16, weight: .bold))
            .padding(.top, 15)
            .padding(.bottom, 14)
            .foregroundColor(textColor)
            .background(configuration.isPressed ? pressedBackgroundColor : backgroundColor)
            .cornerRadius(4)
    }
}

struct BigButton_Previews: PreviewProvider {
    static var previews: some View {
        Button("BigButton Style") {
            print("Hello World!")
        }
        .buttonStyle(BigButton(Color(hex: 0xE60028), Color(hex: 0xE60028).darker()))
        .previewLayout(.fixed(width: 400, height: 80))
    }
}
