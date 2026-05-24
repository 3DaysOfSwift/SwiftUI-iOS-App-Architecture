//
//  PurpleTheme.swift
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
//   It's a color theme, used to display a different color theme.
//   Architectural Layer: The business logic layer (the main non-visual system).
//   Convenience Tip: We used extensions to seperate themes into seperate files providing
//   designers with editable documents. Also allowing us to conveniently load the theme array.
// --------------------------------------------------

import Foundation

extension ThemeLoader {
    var purpleTheme: CalculatorTheme {
        CalculatorTheme(id: "7",
                        background: "#F4F5FA",
                        display: "#1D1D1D",
                        operatorNormal: "#7550FE",
                        operatorSelected: "#4566B6",
                        operatorTitle: "#ffffff",
                        operatorTitleSelected: "#ffffff",
                        pinPad: "#1D1D1D",
                        pinPad123: "#3F3089",
                        pinPadTitle: "#ffffff",
                        extraFunctions: "#F4F5FA",
                        extraFunctionsTitle: "#7550FE",
                        statusBarStyle: .dark)
    }
}
