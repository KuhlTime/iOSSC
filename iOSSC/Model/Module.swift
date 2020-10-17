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
    
    private var examGrade: Grade? {
        return exams.first { exam in
            return exam.passed
        }?.grade
    }
    
    /**
     If the module has no grade assigned to it.
     The grade of the first passed exam is getting returned.
     */
    var computedGrade: Grade? {
        return grade ?? examGrade
    }
}
