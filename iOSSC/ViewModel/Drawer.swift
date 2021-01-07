//
//  Drawer.swift
//  iOSSC
//
//  Created by André Kuhlmann on 26.10.20.
//

import SwiftUI

struct Drawer: View {
    @Binding var show: Bool
    
    @State private var offset: CGFloat = 0
    @State private var opacity: Double = 0.4
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.black)
                .opacity(opacity)
                .ignoresSafeArea()
            VStack {
                Spacer()
                Group {
                    VStack {
                        handle
                        Text("Hello World how are you. Are you respecting the")
                    }
                }
                .padding(.horizontal)
                .frame(maxWidth: .infinity)
                .background(Color.white.ignoresSafeArea())
            }
        }
    }
    
    /**
     The handle view marks the dragable area
     */
    var handle: some View {
        HStack {
            Spacer()
            Rectangle()
                .foregroundColor(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                .frame(width: 42, height: 4)
                .cornerRadius(2)
                .padding(.vertical, 8)
            Spacer()
        }
    }
}

struct Drawer_Previews: PreviewProvider {
    struct PreviewView: View {
        var body: some View {
            Drawer(show: .constant(true))
        }
    }
    
    static var previews: some View {
        PreviewView()
    }
}
