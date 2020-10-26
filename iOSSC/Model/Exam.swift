//
//  Exam.swift
//  iOSSC
//
//  Created by André Kuhlmann on 16.10.20.
//

import Foundation

struct Exam: Codable {
    let semester: Semester
    let grade: Grade
    let passed: Bool
    let examinationDate: String
    let score: Score
}
