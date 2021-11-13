//
//  GradePill.swift
//  iOSSC
//
//  Created by André Kuhlmann on 13.11.21.
//

import SwiftUI
import Haptica

struct GradePill: View {
    @State var grade: Grade?
    @Binding var mode: GradeMode
    
    init(for grade: Grade?, in mode: Binding<GradeMode> = .constant(.normal)) {
        self.grade = grade
        self._mode = mode
    }
    
    var body: some View {
        Text(text ?? "-")
            .fontWeight(.bold)
            .frame(width: 40)
            .padding(.vertical, 4)
            .padding(.horizontal, 10)
            .foregroundColor(.white)
            .background(
                Capsule()
                    .foregroundColor(color)
            )
            .onTapGesture {
                tapHandler()
            }
    }
    
    func tapHandler() {
        Haptic.impact(.light).generate()
        mode.next()
    }
    
    var color: Color {
        if mode == .color || mode == .colorEmoji {
            return grade?.color ?? Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))
        } else {
            return Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))
        }
    }
    
    var text: String? {
        if mode == .emoji || mode == .colorEmoji {
            return grade?.emoji
        } else {
            return grade?.description
        }
    }
}

struct GradePill_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            GradePill(for: 1.3, in: .constant(.normal))
            GradePill(for: 2.9, in: .constant(.color))
            GradePill(for: 2.4, in: .constant(.colorEmoji))
            GradePill(for: 2.4, in: .constant(.emoji))
            GradePill(for: nil, in: .constant(.colorEmoji))
        }
        .previewLayout(.fixed(width: 200, height: 100))
    }
}
