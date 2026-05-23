//
//  PinkTheme.swift
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
    var pinkTheme: CalculatorTheme {
        CalculatorTheme(id: "5",
                        background: "#253C5B",
                        display: "#EBF0EF",
                        operatorNormal: "#FA569C",
                        operatorSelected: "#0265FF",
                        operatorTitle: "#EBF0EF",
                        operatorTitleSelected: "#ffffff",
                        pinPad: "#16253A",
                        pinPad123: "#2E4866",
                        pinPadTitle: "#EBF0EF",
                        extraFunctions: "#294666",
                        extraFunctionsTitle: "#EBF0EF",
                        statusBarStyle: .light)
    }
}
