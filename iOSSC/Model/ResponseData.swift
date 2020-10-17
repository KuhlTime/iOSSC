//
//  ResponseData.swift
//  iOSSC
//
//  Created by André Kuhlmann on 16.10.20.
//

import Foundation

/**
 The data encaluplated inside the GET `/ossc/modules` respones.
 */
struct ResponseData: Decodable {
    let duration: Int
    let student: Student
    let totalCreditPoints: Int
    let avgGrade: Grade
    let modules: [Module]
}
