//
//  WashedOutTheme.swift
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
//   It's a color theme, used to display a different color theme.
//   Architectural Layer: The business logic layer (the main non-visual system).
//
//   💡 Convenience Tip 👉🏻 We used extensions to seperate themes into seperate files providing
//   designers with editable documents. Also allowing us to conveniently load the theme array.
// -------------------------------------------------------------------------------------------

import Foundation

extension ThemeLoader {
    var washedOutTheme: CalculatorTheme {
        CalculatorTheme(id: "8",
                        background: "#ECF5FF",
                        display: "#0D2A4B",
                        operatorNormal: "#A3CFF9",
                        operatorSelected: "#0D2A4B",
                        operatorTitle: "#5487BA",
                        operatorTitleSelected: "#ffffff",
                        pinPad: "#1D1D1D",
                        pinPad123: "#5487BA",
                        pinPadTitle: "#ffffff",
                        extraFunctions: "#A3CFF9",
                        extraFunctionsTitle: "#5487BA",
                        statusBarStyle: .dark)
    }
}
