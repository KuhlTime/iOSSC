//
//  GradeMode.swift
//  iOSSC
//
//  Created by André Kuhlmann on 17.10.20.
//

import Foundation

enum GradeMode {
    case normal, color, normalEmoji, colorEmoji
    
    static var all: [GradeMode] {
        return [.normal, .colorEmoji]
    }
    
    mutating func next() {
        let i = GradeMode.all.firstIndex(of: self)!
        self = GradeMode.all[(i + 1) % GradeMode.all.count]
    }
}
