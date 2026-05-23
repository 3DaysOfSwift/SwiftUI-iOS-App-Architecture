//
//  AppConstants.swift
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
//   It's a centralised area to store values. Here we can store a list of constant values
//   that we don't want to repeat or duplicate throughout our codebase.
// --------------------------------------------------

import Foundation
import UIKit

// MARK: - ThemeManager

extension ThemeManager {
    // store constants in enums
    enum keys {
        static let dataStore = "3DaysOfSwift.com.calc.ThemeManager.theme"
    }
}

// MARK: - Calculator

extension Calculator {
    // store constants in enums
    enum keys {
        static let dataStore = "3DaysOfSwift.com.calc.CalculatorEngine.total"
    }
}
