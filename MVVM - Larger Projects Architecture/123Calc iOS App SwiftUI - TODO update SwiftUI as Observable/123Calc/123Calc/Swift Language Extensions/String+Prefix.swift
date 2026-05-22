//
//  String+Prefix.swift
//  123Calc
//
//  Created by 3DaysOfSwift.com on 23/09/2025.
//
//  3DaysOfSwift.com                → All rights reserved
//  Website                         → https://www.3DaysOfSwift.com
//
//  We 🧡 Swift
//  Welcome to our community of 3DaysOfSwift.com developers!
//
//  🧕🏻🙋🏽‍♂️👨🏿‍💼👩🏼‍💼👩🏻‍💻💁🏼‍♀️👨🏼‍💼🙋🏻‍♂️🙋🏻‍♀️👩🏼‍💻🙋🏿💁🏽‍♂️🙋🏽‍♀️🙋🏿‍♀️🧕🏾🙋🏼‍♂️
// -------------------------------------------------------------------------------------------
//
// → What's This File?
//   It's an extension for Swift Strings. We added a reusable function to add and remove
//   a prefix from a string
//   Architectural Layer: An extension to the Swift programming language.
//
// -------------------------------------------------------------------------------------------

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
