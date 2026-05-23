//
//  ThemeLoader.swift
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
//   It's a struct that provides access to all of the color themes.
//   Architectural Layer: The business logic layer (the main non-visual system).
// --------------------------------------------------

import Foundation

struct ThemeLoader {
    var allThemes: [CalculatorTheme] {
        [appBrandTheme,
         purpleTheme,
         orangeTheme,
         pinkTheme,
         lightBlueTheme,
         electroTheme,
         washedOutTheme,
         bloodOrangeTheme,
         darkBlueTheme]
    }
}
