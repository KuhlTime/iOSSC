//
//  Grade.swift
//  iOSSC
//
//  Created by André Kuhlmann on 16.10.20.
//

import SwiftUI

typealias Grade = Double

extension Grade {
    var word: String? {
        switch self {
        case let x where 1.5 >= x && x >= 1:
            return "sehr gut"
        case let x where 2.5 >= x && x > 1.5:
            return "gut"
        case let x where 3.5 >= x && x > 2.5:
            return "befriedigend"
        case let x where 4.0 >= x && x > 3.5:
            return "ausreichend"
        case let x where x == 5:
            return "nicht ausreichend"
        default:
            return nil
        }
    }
    
    var emoji: String? {
        let array: [String]!
        
        switch self {
        case let x where 1.5 >= x && x >= 1:
            array = ["🥳"]
        case let x where 2.5 >= x && x > 1.5:
            array = ["☺️"]
        case let x where 3.5 >= x && x > 2.5:
            array = ["😐"]
        case let x where 4.0 >= x && x > 3.5:
            array = ["🥵"]
        case let x where x == 5:
            array = ["🤬"]
        default:
            return nil
        }
        
        return array.randomElement()
    }
    
    var color: Color {
        switch self {
        case let x where 1.5 >= x && x >= 1:
            return Color(#colorLiteral(red: 0.1803921569, green: 0.8, blue: 0.4431372549, alpha: 1))
        case let x where 2.5 >= x && x > 1.5:
            return Color(#colorLiteral(red: 0.568627451, green: 0.7843137255, blue: 0.2470588235, alpha: 1))
        case let x where 3.5 >= x && x > 2.5:
            return Color(#colorLiteral(red: 0.9450980392, green: 0.768627451, blue: 0.05882352941, alpha: 1))
        case let x where 4.0 >= x && x > 3.5:
            return Color(#colorLiteral(red: 0.9019607843, green: 0.4941176471, blue: 0.1333333333, alpha: 1))
        default:
            return Color(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1))
        }
    }
    
    var color2: Color {
        guard self != 5 else { return Color(hex: 0xff3c24) }
        
        let hexColors: [UInt] = [0x8bff24, 0x9fff23, 0xc0ff1f, 0xcfff1d, 0xe4ff19, 0xfff40e, 0xffe711, 0xffd017, 0xffc215, 0xfeaa19, 0xff8a1b, 0xfe6e1e]
        let colors = hexColors.map { Color(hex: $0) }
        
        let colorIndex = Int((self / 4 * Double(colors.count)).rounded(.down))
        print(colorIndex)
        return colors[colorIndex - 1]
    }
}
