//
//  Placeholder.swift
//  iOSSC
//
//  Created by André Kuhlmann on 17.10.20.
//

import SwiftUI

/**
 `PlaceHolder` is a `ViewModifier` which can be applied to an `TextField` in order to - well - set a placeholder.
 */
struct PlaceHolder<T: View>: ViewModifier {
    var placeHolder: T
    var show: Bool
    func body(content: Content) -> some View {
        ZStack(alignment: .leading) {
            if show { placeHolder }
            content
        }
    }
}

extension View {
    func placeHolder<T:View>(_ holder: T, show: Bool) -> some View {
        self.modifier(PlaceHolder(placeHolder:holder, show: show))
    }
}
