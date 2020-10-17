//
//  Student.swift
//  iOSSC
//
//  Created by André Kuhlmann on 16.10.20.
//

import Foundation

struct Student: Decodable {
    let name: String
    let registration: Int
    let birthday, cityOfBirth, degree, faculty: String
    let address: String
}
