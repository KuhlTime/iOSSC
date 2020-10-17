//
//  ModuleRow.swift
//  iOSSC
//
//  Created by André Kuhlmann on 16.10.20.
//

import SwiftUI
import Haptica

struct ModuleRow: View {
    let module: Module
    @Binding var mode: GradeMode
    
    init(for module: Module, in mode: Binding<GradeMode> = .constant(.normal)) {
        self.module = module
        self._mode = mode
        
        UITableViewCell.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading) {
                Text(module.name)
                Text("\(module.id.description) - \(module.passed ? "Bestanden" : "Nicht Bestanden")")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Text(text ?? "-")
                .fontWeight(.bold)
                .frame(width: 40)
                .padding(.vertical, 4)
                .padding(.horizontal, 10)
                .foregroundColor(.white)
                .background(Capsule().foregroundColor(color).onTapGesture {
                    Haptic.impact(.medium).generate()
                    mode.next()
                })
        }
    }
    
    var color: Color {
        let grade = module.computedGrade
        
        if mode == .color || mode == .colorEmoji {
            return grade?.color ?? Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))
        } else {
            return Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))
        }
    }
    
    var text: String? {
        let grade = module.computedGrade
        
        if mode == .emoji || mode == .colorEmoji {
            return grade?.emoji
        } else {
            return grade?.description
        }
    }
}

struct ModuleRow_Previews: PreviewProvider {
    static var previews: some View {
        ModuleRow(for: Module(exams: [], workExperiences: [], id: 12010, name: "Mathematik I", passed: true, creditPoints: 10, grade: 2.3, attempts: Attempts(exams: 2, workExperiences: 1)))
            .previewLayout(.fixed(width: 300, height: 60))
        
        ModuleRow(for: Module(exams: [], workExperiences: [], id: 12010, name: "G 3 Grundlagen der Elektrotechnik III", passed: true, creditPoints: 10, grade: nil, attempts: Attempts(exams: 2, workExperiences: 1)))
            .previewLayout(.fixed(width: 300, height: 60))
    }
}
