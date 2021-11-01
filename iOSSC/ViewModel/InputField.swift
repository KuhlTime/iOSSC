//
//  InputField.swift
//  iOSSC
//
//  Created by André Kuhlmann on 05.05.21.
//

import SwiftUI

struct InputField: View {
    let title: String
    let isSecure: Bool
    @Binding var text: String
    
    init(_ title: String, text: Binding<String>, isSecure: Bool = false) {
        self.title = title
        self.isSecure = isSecure
        self._text = text
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color.white.opacity(0.2), lineWidth: 2)
                .foregroundColor(.black.opacity(0.3))
            
            ZStack(alignment: .leading) {
                if (text.isEmpty) {
                    Text(title)
                        .foregroundColor(.white.opacity(0.6))
                }
                
                Group {
                    if (isSecure) {
                        SecureField("", text: $text)
                    }
                    else {
                        TextField("", text: $text)
                    }
                }
                .foregroundColor(.white)
                .disableAutocorrection(true)
            }
            .padding(.horizontal)
        }
        .frame(height: 47)
    }
}

struct InputField_Previews: PreviewProvider {
    static var previews: some View {
        InputField("Placeholder", text: .constant(""))
            .padding()
            .background(Color.gray)
            .previewLayout(.fixed(width: 300, height: 70))
    }
}
