//
//  Module.swift
//  iOSSC
//
//  Created by André Kuhlmann on 16.10.20.
//

import Foundation

struct Module: Decodable, Identifiable, Hashable {
    let exams: [Exam]
    let workExperiences: [WorkExperience]
    let id: Int
    let name: String
    let passed: Bool
    let creditPoints: Int
    let grade: Grade?
    let factor: Int?
    let attempts: Attempts
    
    private var examGrade: Grade? {
        return exams.first { exam in
            return exam.passed
        }?.grade
    }
    
    var computedGrade: Grade? {
        return examGrade ?? grade
    }
    
    static func == (lhs: Module, rhs: Module) -> Bool {
        return lhs.id == rhs.id
    }
}
