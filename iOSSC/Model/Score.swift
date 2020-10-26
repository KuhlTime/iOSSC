//
//  Score.swift
//  iOSSC
//
//  Created by André Kuhlmann on 26.10.20.
//

import Foundation

struct Score: Codable {
    let grades: [Int]
    let id: Int
    let semester: Semester
    let updated, examinationDate: String
    let attendes: Attendes
    let name: String
    let avarage: Grade
}
