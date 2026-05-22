//
//  AppBrandTheme.swift
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
    var appBrandTheme: CalculatorTheme {
        CalculatorTheme(id: "3",
                        background: "#F6F8F9",
                        display: "#000000",
                        operatorNormal: "#4BE6A9",
                        operatorSelected: "#70729D",
                        operatorTitle: "#14145C",
                        operatorTitleSelected: "#ffffff",
                        pinPad: "#E9F0F4",
                        pinPad123: "#D3E9F4",
                        pinPadTitle: "#000000",
                        extraFunctions: "#E9F0F4",
                        extraFunctionsTitle: "#4BE6A9",
                        statusBarStyle: .dark)
    }
}
