//
//  BlurView.swift
//  iOSSC
//
//  Created by André Kuhlmann on 26.10.20.
//

// Original: https://designcode.io/swiftui-handbook-background-blur

import SwiftUI

struct BlurView: UIViewRepresentable {
    typealias UIViewType = UIView
        var style: UIBlurEffect.Style

    func makeUIView(context: UIViewRepresentableContext<BlurView>) -> UIView {
        let view = UIView(frame: CGRect.zero)
        view.backgroundColor = .clear

        let blurEffect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(blurView, at: 0)

        NSLayoutConstraint.activate([
            blurView.widthAnchor.constraint(equalTo: view.widthAnchor),
            blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
            ])

        return view
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<BlurView>) {}
}

struct BlurView_Previews: PreviewProvider {
    static var previews: some View {
        BlurView(style: .regular)
    }
}
