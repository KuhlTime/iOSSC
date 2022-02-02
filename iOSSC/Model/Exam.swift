//
//  Exam.swift
//  iOSSC
//
//  Created by André Kuhlmann on 16.10.20.
//

import Foundation

struct Exam: Decodable, Hashable {
    let grade: Grade? // For the practical exam the grade gets returned as null
    let passed: Bool
    let examinationDate: Date
    let semester: Semester
    let score: ExamScore?
}
