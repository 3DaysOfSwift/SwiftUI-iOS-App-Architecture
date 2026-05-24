//
//  String+Prefix.swift
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
//   It's an extension for Swift Strings. We added a reusable function to add and remove
//   a prefix from a string
//   Architectural Layer: An extension to the Swift programming language.
// --------------------------------------------------

import Foundation

extension String {
    mutating func addPrefixIfNeeded(_ prefix: String) {
        guard hasPrefix(prefix) == false else { return }
        self = prefix + self
    }

    mutating func removePrefixIfNeeded(_ prefix: String) {
        guard hasPrefix(prefix) == true else { return }
        self = String(dropFirst(prefix.count))
    }
}
