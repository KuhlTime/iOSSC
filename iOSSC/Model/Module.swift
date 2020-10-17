//
//  Module.swift
//  iOSSC
//
//  Created by André Kuhlmann on 16.10.20.
//

import Foundation

struct Module: Decodable, Identifiable {
    let exams: [Exam]
    let workExperiences: [WorkExperience]
    let id: Int
    let name: String
    let passed: Bool
    let creditPoints: Int
    let grade: Grade?
    let attempts: Attempts
}
