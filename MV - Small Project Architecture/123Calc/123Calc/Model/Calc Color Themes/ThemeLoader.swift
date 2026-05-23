//
//  ThemeLoader.swift
//  123Calc
//
//  Created by 3DaysOfSwift.com on 23/09/2025.
//
//  3DaysOfSwift.com                → All rights reserved
//  Website                         → https://www.3DaysOfSwift.com
//
//  We 🧡 Swift
//  Built for professional iOS developers.
//
//  🧕🏻🙋🏽‍♂️👨🏿‍💼👩🏼‍💼👩🏻‍💻💁🏼‍♀️👨🏼‍💼🙋🏻‍♂️🙋🏻‍♀️👩🏼‍💻🙋🏿💁🏽‍♂️🙋🏽‍♀️🙋🏿‍♀️🧕🏾🙋🏼‍♂️
// -------------------------------------------------------------------------------------------
//
// → What's This File?
//   It's a struct that provides access to all of the color themes.
//   Architectural Layer: The business logic layer (the main non-visual system).
//
// -------------------------------------------------------------------------------------------

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
