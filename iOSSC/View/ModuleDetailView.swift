//
//  ModuleDetailView.swift
//  iOSSC
//
//  Created by André Kuhlmann on 13.11.21.
//

import SwiftUI

struct ModuleDetailView: View {
    @State var module: Module
    @Binding var mode: GradeMode
    
    init(for module: Module, in mode: Binding<GradeMode>) {
        self.module = module
        self._mode = mode
        
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                HStack {
                    Text(module.name)
                        .font(.custom("HSD Sans", size: 26))
                        .foregroundColor(.hsd)
                    Spacer()
                }
                .padding()
                
                ScrollView {
                    if module.exams.count > 0 {
                        sectionHeading(name: "Prüfungen")
                        
                        ForEach(module.exams, id: \.self, content: { exam in
                            Row(exam.examinationDate.getFormattedDate(format: "dd.MM.yyyy"), color: exam.score != nil ? .white.opacity(0.2) : nil) {
                                GradePill(for: exam.grade, in: $mode)
                            }
                        })
                    }
                    
                    if module.workExperiences.count > 0 {
                        sectionHeading(name: "Praktika")
                            .padding(.top, module.exams.count > 0 ? 24 : 0)
                        
                        ForEach(module.workExperiences, id: \.self) { experience in
                            Row(experience.semester) {
                                Text(experience.passed ? "✅" : "❌")
                            }
                        }
                    }
                }
                .padding(.horizontal)
            
                Spacer()
            }
        }
        .background(
            BackgroundView()
        )
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                GradePill(for: module.computedGrade, in: $mode)
            }
        }
    }
    
    struct Row<Content: View>: View {
        private let title: String
        private let trailing: Content
        private let color: Color?
        
        init(_ title: String, color: Color? = nil, @ViewBuilder trailing: @escaping () -> Content) {
            self.title = title
            self.color = color
            self.trailing = trailing()
        }
        
        var body: some View {
            HStack {
                Text(title).foregroundColor(.white)
                Spacer()
                trailing
            }
            .padding(.horizontal, 24)
            .frame(height: 54)
            .background(
                Capsule().foregroundColor(color ?? .black.opacity(0.2))
            )
        }
    }
    
    func sectionHeading(name: String) -> some View {
        HStack {
            Text(name)
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.white)
            Spacer()
        }
        .padding(.horizontal)
    }
    
    var gradeText: String {
        guard let grade = module.grade else { return "" }
        return "Note: \(grade.description)"
    }
    
    var passedText: String {
        let id = module.id.description
        let passed = module.passed ? "Bestanden" : "Nicht Bestanden"
        return "\(id) - \(passed)"
    }
}

//struct ModuleDetailView_Previews: PreviewProvider {
//    static let module = Module(exams: [Exam(grade: 1.6, passed: true, examinationDate: Date())], workExperiences: [WorkExperience(semester: "2021", passed: true), WorkExperience(semester: "2020", passed: false)], id: 123456, name: "Test Module", passed: true, creditPoints: 5, grade: 1.6, attempts: Attempts(exams: 1, workExperiences: 0))
//
//    static var previews: some View {
//        ModuleDetailView(for: module, in: .constant(.normal))
//    }
//}
