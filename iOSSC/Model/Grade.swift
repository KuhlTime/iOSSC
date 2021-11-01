//
//  Grade.swift
//  iOSSC
//
//  Created by André Kuhlmann on 16.10.20.
//

import SwiftUI

typealias Grade = Double

extension Grade {
    var range: GradeRange? {
        return GradeRange.getRange(for: self)
    }
    
    var word: String? {
        return range?.returnValue(from: ["sehr gut", "gut", "befriedigend", "ausreichend", "nicht ausreichend"])
    }
    
    var emoji: String? {
        return range?.returnValue(from: ["🥳", "☺️", "😐", "🥵", "🤬"])
    }
    
    var color: Color? {
        return range?.returnValue(from: [Color(#colorLiteral(red: 0.1803921569, green: 0.8, blue: 0.4431372549, alpha: 1)), Color(#colorLiteral(red: 0.568627451, green: 0.7843137255, blue: 0.2470588235, alpha: 1)), Color(#colorLiteral(red: 0.9450980392, green: 0.768627451, blue: 0.05882352941, alpha: 1)), Color(#colorLiteral(red: 0.9019607843, green: 0.4941176471, blue: 0.1333333333, alpha: 1)), Color(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1))])
    }
    
    enum GradeRange {
        case one, two, three, four, five
        
        var value: ClosedRange<Double> {
            switch self {
            case .one: return 1...1.5
            case .two: return 1.5.nextUp...2.5
            case .three: return 2.5.nextUp...3.5
            case .four: return 3.5.nextUp...4
            case .five: return 4.nextUp...5
            }
        }
        
        static var all: [GradeRange] {
            return [.one, .two, .three, .four, .five]
        }
        
        func returnValue<T>(from array: [T]) -> T? {
            guard let i = GradeRange.all.firstIndex(of: self) else { return nil }
            return array[i]
        }
        
        static func getRange(for grade: Grade) -> GradeRange {
            return all.first {
                return $0.value.contains(grade)
            }!
        }
    }
}
