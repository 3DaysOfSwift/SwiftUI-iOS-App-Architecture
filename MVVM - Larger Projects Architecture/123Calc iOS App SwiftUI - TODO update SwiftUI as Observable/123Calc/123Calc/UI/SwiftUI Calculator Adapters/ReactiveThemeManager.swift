//
//  ReactiveThemeManager.swift
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
//   It's a class created to be an adapter between the Calculator system and the reactive
//   SwiftUI framework in order to automatically trigger our SwiftUI Views to redraw
//   themselves.
//   Architectural Layer: The user interface (UI) of the app.
//
// -------------------------------------------------------------------------------------------

import Foundation

class ReactiveThemeManager: ObservableObject {
    private let themeManager = ThemeManager()
    @Published var currentTheme: CalculatorTheme

    init() {
        currentTheme = themeManager.currentTheme
    }

    func moveToNextTheme() {
        themeManager.moveToNextTheme()
        refreshCurrentTheme()
    }

    private func refreshCurrentTheme() {
        currentTheme = themeManager.currentTheme
    }
}
