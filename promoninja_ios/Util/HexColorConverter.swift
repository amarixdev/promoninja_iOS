//
//  HexColorConverter.swift
//  promoninja_ios
//
//  Created by Amari DeVaughn on 11/20/23.
//

import SwiftUI

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in:CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
        (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .displayP3,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
    
    
    init(rgbString: String) {
        var numbers:[Double] = []
                
        //isolate from rgb
       let rgbValues = rgbString.split(separator: "b", maxSplits: 1)
        
        //isolate values
        var separatedValues = rgbValues[1].split(separator: ",", maxSplits: 3)
        
        //remove parenthesis
        separatedValues[0].removeFirst()
        separatedValues[2].removeLast()
        
        for num in separatedValues {
            numbers.append (
               Double(num) ?? 0
            )
        }
    
        self.init(red: CGFloat( (numbers[0] / 255)), green: CGFloat(  (numbers[1] / 255)), blue: CGFloat( (numbers[2] / 255)))
    }
    
   
}

