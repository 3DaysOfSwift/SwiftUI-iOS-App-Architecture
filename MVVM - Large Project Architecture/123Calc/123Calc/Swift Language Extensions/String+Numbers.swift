//
//  String+Numbers.swift
//  123Calc
//
//  © 2026 3DaysOfSwift.com
//  https://www.3DaysOfSwift.com
//
//  We 🧡 Swift
//  Built for professional iOS developers.
//
// --------------------------------------------------
// → What's This File?
//   It's an extension for Swift Strings. We added a computed property to produce the numeric
//   equivalent if it exists.
//   Architectural Layer: An extension to the Swift programming language.
// --------------------------------------------------

import Foundation

extension String {
    var doubleValue: Double? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.number(from: self)?.doubleValue
    }
}
