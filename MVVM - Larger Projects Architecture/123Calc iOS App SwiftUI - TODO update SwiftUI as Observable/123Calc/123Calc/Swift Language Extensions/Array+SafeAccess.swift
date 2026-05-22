//
//  Array+SafeAccess.swift
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
//   It's an extension for Swift Arrays. We added a nice safety feature for accessing values.
//   This method of accessing values within an array is regularly used in the iOS industry!
//   We would highly recommend that you start using it too.
//   Architectural Layer: An extension to the Swift programming language.
//
// -------------------------------------------------------------------------------------------

import Foundation

extension Array {
    subscript(safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}
