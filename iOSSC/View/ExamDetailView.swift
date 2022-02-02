//
//  ExamDetailView.swift
//  iOSSC
//
//  Created by André Kuhlmann on 14.11.21.
//

import SwiftUI

struct ExamDetailView: View {
    let exam: Exam
    
    init(for exam: Exam) {
        self.exam = exam
    }
    
    var body: some View {
        ZStack {
            BackgroundView()
            
        }
    }
}

struct ExamDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ExamDetailView(for: Exam(grade: 1.3, passed: true, examinationDate: Date(), semester: Semester(winter: false, year: 2021), score: ExamScore(id: 123456, name: "Elektrotechnik 1", attendes: ExamScore.Attendes(passed: 4, total: 9, failed: 5), updated: Date(), examinationDate: Date(), grades: [2, 1, 1, 0, 5], avarage: 3.0, semester: Semester(winter: false, year: 2021))))
    }
}
