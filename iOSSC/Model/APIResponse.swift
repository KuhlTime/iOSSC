//
//  APIResponse.swift
//  iOSSC
//
//  Created by André Kuhlmann on 16.10.20.
//

import Foundation

struct APIResponse<T: Decodable>: Decodable {
    private let type: String
    let message: String?
    
    private(set) var data: T?
    
    var status: Status {
        return type == "success" ? .success : .failed
    }
    
    enum Status {
        case success
        case failed
    }
}
