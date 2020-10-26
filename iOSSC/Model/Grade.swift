//
//  Grade.swift
//  iOSSC
//
//  Created by André Kuhlmann on 16.10.20.
//

import SwiftUI

/**
 A `Grade` is a `Double` typealias with additional information about that `Grade`.
 */
typealias Grade = Double

extension Grade {
    /**
     Returns the german word associated with that `Grade`.
     */
    var word: String? {
        return switchGrade("sehr gut", "gut", "befriedigend", "ausreichend", "nicht ausreichend")
    }
    
    /**
     Returns an Emoji `String` representing the `Grade` in a fun way.
     */
    var emoji: String {
        let array = switchGrade(["🥳"], ["☺️"], ["😐"], ["🥵"], ["🤬"], defaultValue: ["🤷‍♂️"])
        return array.randomElement()! // Can force unwrap because all paths lead to a value.
    }
    
    /**
     Returns a color representing the `Grade`.
     */
    var color: Color? {
        return switchGrade(Color(#colorLiteral(red: 0.1803921569, green: 0.8, blue: 0.4431372549, alpha: 1)), Color(#colorLiteral(red: 0.568627451, green: 0.7843137255, blue: 0.2470588235, alpha: 1)), Color(#colorLiteral(red: 0.9450980392, green: 0.768627451, blue: 0.05882352941, alpha: 1)), Color(#colorLiteral(red: 0.9019607843, green: 0.4941176471, blue: 0.1333333333, alpha: 1)), Color(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)))
    }
    
    /**
     Returns the `Grade.Range` to which this `Grade` belongs to.
     */
    var inRange: GradeRange? {
        return switchGrade(.one, .two, .three, .four, .five)
    }
    
    /**
     Switch statement wrapper with default value.
     */
    private func switchGrade<T: Any>(_ one: T, _ two: T, _ three: T, _ four: T, _ five: T, defaultValue: T) -> T {
        switch self {
        case let x where GradeRange.one.rawValue >= x:
            return one
        case let x where GradeRange.two.rawValue >= x:
            return two
        case let x where GradeRange.three.rawValue >= x:
            return three
        case let x where GradeRange.four.rawValue >= x:
            return four
        case let x where GradeRange.five.rawValue >= x:
            return five
        default:
            return defaultValue
        }
    }
    
    /**
     Switch statement wrapper **without** default value. This function returns an `Optional`.
     */
    private func switchGrade<T: Any>(_ one: T, _ two: T, _ three: T, _ four: T, _ five: T) -> T? {
        switch self {
        case let x where GradeRange.one.rawValue >= x:
            return one
        case let x where GradeRange.two.rawValue >= x:
            return two
        case let x where GradeRange.three.rawValue >= x:
            return three
        case let x where GradeRange.four.rawValue >= x:
            return four
        case let x where GradeRange.five.rawValue >= x:
            return five
        default:
            return nil
        }
    }
    
    /**
     The `Grade.GradeRange` enumeration defines the **maximum value** of a grades range.
     */
    enum GradeRange: Double {
        case one = 1.5
        case two = 2.5
        case three = 3.5
        case four = 4
        case five = 5
    }
}
