//
//  Array+SafeAccess.swift
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
//   It's an extension for Swift Arrays. We added a nice safety feature for accessing values.
//   This method of accessing values within an array is regularly used in the iOS industry!
//   We would highly recommend that you start using it too.
//   Architectural Layer: An extension to the Swift programming language.
// --------------------------------------------------

import Foundation

extension Array {
    subscript(safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}
