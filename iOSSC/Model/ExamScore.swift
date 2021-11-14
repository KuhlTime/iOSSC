//
//  ExamScore.swift
//  iOSSC
//
//  Created by André Kuhlmann on 14.11.21.
//

import Foundation

typealias GradesArray = [Int]

struct ExamScore: Codable, Hashable {
    let id: Int
    let name: String
    let attendes: Attendes
    let updated: Date
    let examinationDate: Date
    let grades: GradesArray
    let avarage: Grade
    let semester: Semester
    
    struct Attendes: Codable, Hashable {
        let passed: Int
        let total: Int
        let failed: Int
    }
}
