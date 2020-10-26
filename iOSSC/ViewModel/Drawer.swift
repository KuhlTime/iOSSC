//
//  Drawer.swift
//  iOSSC
//
//  Created by André Kuhlmann on 26.10.20.
//

import SwiftUI

struct Drawer: View {
    @Binding var shown: Bool
    
    @State private var offset: CGFloat = 0
    @State private var opacity: Double = 0.4
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.black)
                .opacity(opacity)
                .ignoresSafeArea(.all)
            VStack {
                Spacer()
                VStack {
                    handle
                    Text("Drawer")
                        .fontWeight(.bold)
                    Text("This is a neat little Drawer which can be dragged")
                }
                .background(backgroundView)
                .offset(x: 0, y: offset)
            }
        }
    }
    
    var backgroundView: some View {
        Rectangle()
            .foregroundColor(.white)
            .ignoresSafeArea()
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
    static var previews: some View {
        ZStack {
            Image("Unsplash")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
            Drawer(shown: .constant(true))
        }
    }
}
