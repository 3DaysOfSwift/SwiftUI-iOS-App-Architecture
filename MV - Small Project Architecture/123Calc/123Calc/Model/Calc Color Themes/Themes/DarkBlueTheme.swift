//
//  DarkBlueTheme.swift
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
//   It's a color theme, used to display a different color theme.
//   Architectural Layer: The business logic layer (the main non-visual system).
//
//   💡 Convenience Tip 👉🏻 We used extensions to seperate themes into seperate files providing
//   designers with editable documents. Also allowing us to conveniently load the theme array.
// -------------------------------------------------------------------------------------------

import Foundation

extension ThemeLoader {
    var darkBlueTheme: CalculatorTheme {
        CalculatorTheme(id: "6",
                        background: "#1D1D1D",
                        display: "#727272",
                        operatorNormal: "#4566B6",
                        operatorSelected: "#4566B6",
                        operatorTitle: "#ffffff",
                        operatorTitleSelected: "#ffffff",
                        pinPad: "#1D1D1D",
                        pinPad123: "#3F563F",
                        pinPadTitle: "#767676",
                        extraFunctions: "#323232",
                        extraFunctionsTitle: "#FFFFFF",
                        statusBarStyle: .light)
    }
}
