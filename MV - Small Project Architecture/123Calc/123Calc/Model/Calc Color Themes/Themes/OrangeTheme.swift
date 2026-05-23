//
//  OrangeTheme.swift
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
    var orangeTheme: CalculatorTheme {
        CalculatorTheme(id: "10",
                        background: "#DC6969",
                        display: "#ffffff",
                        operatorNormal: "#CC4D4D",
                        operatorSelected: "#AB2F2F",
                        operatorTitle: "#ffffff",
                        operatorTitleSelected: "#ffffff",
                        pinPad: "#C94848",
                        pinPad123: "#AB2F2F",
                        pinPadTitle: "#ffffff",
                        extraFunctions: "#D05353",
                        extraFunctionsTitle: "#ffffff",
                        statusBarStyle: .light)
    }
}
