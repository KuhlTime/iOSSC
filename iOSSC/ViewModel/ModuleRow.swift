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
                    .foregroundColor(.white)
                Text(text)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            GradePill(for: module.computedGrade, in: $mode)
        }
        .frame(minHeight: 44)
    }
    
    var text: String {
        let id = module.id.description
        let passed = module.passed ? "Bestanden" : "Nicht Bestanden"
        let attempts = module.attempts.exams
        return "\(id) - \(passed) - Versuche: \(attempts)"
    }
}

struct ModuleRow_Previews: PreviewProvider {
    static let attempts = Attempts(exams: 2, workExperiences: 1)
    
    static var previews: some View {
        Group {
            ModuleRow(for: Module(exams: [], workExperiences: [], id: 12010, name: "Mathematik I", passed: true, creditPoints: 10, grade: 2.3, factor: 1, attempts: attempts))
            ModuleRow(for: Module(exams: [], workExperiences: [], id: 12010, name: "G 3 Grundlagen der Elektrotechnik III", passed: true, creditPoints: 10, grade: nil, factor: nil, attempts: attempts))
        }
        .background(Color.black)
        .previewLayout(.fixed(width: 300, height: 60))
    }
}
