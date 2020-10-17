//
//  Exam.swift
//  iOSSC
//
//  Created by André Kuhlmann on 16.10.20.
//

import Foundation

struct Exam: Decodable {
    let grade: Grade
    let passed: Bool
    let examinationDate: String
}
