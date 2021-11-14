//
//  Date.swift
//  iOSSC
//
//  Created by André Kuhlmann on 14.11.21.
//

import Foundation

/**
 https://stackoverflow.com/a/43434964/4179020
 */
extension Date {
   func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}
