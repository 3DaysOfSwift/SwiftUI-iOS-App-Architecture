//
//  ThemeManager.swift
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
//   It's a color theme manager, it stores all of our color themes.
//   Architectural Layer: Business Logic Layer
// --------------------------------------------------

import Foundation
import Observation

class ThemeManager: ObservableObject {
    
    // MARK: - Properties

    private let userPreferenceForCurrentTheme: UserPreference<CalculatorTheme>

    // MARK: - Theme Options

    private(set) var themes: [CalculatorTheme] = []

    // MARK: - Accessing The Current Theme

    private var savedTheme: CalculatorTheme? // NOTE: We did not use DI - we felt there was no real reason to here (KISS)
    @Published private(set) var currentTheme: CalculatorTheme
    
    // MARK: - Initialiser

    init(_ userPreferenceForSavedTheme: UserPreference<CalculatorTheme>) {
        self.userPreferenceForCurrentTheme = userPreferenceForSavedTheme
        currentTheme = themes.first ?? ThemeLoader().appBrandTheme
        savedTheme = currentTheme
        populateSelectionOfThemes()
        let _ = restoreSavedTheme()
    }

    // MARK: - Populate Theme Selection

    private func populateSelectionOfThemes() {
        themes = ThemeLoader().allThemes
    }

    // MARK: - Save & Restore From Disk

    private func saveThemeToDisk(_ theme: CalculatorTheme) {
        userPreferenceForCurrentTheme.set(theme)
    }

    private func restoreSavedTheme() -> Bool {
        if let previousTheme = userPreferenceForCurrentTheme.get() {
            savedTheme = previousTheme
            return true
        }
        return false
    }

    // MARK: - Changing Themes

    func moveToNextTheme() {
        let themeID = currentTheme.id
        let index = themes.firstIndex { calculatorTheme in
            calculatorTheme.id == themeID
        }

        // → The user is using a theme which has been removed. Reset to the first theme.
        guard let indexOfExistingTheme = index else {
            if let firstTheme = themes.first {
                updateSystemWithTheme(firstTheme)
            }
            return
        }

        // → Move to the next theme
        var nextThemeIndex = indexOfExistingTheme + 1
        if nextThemeIndex > themes.count - 1 {
            nextThemeIndex = 0
        }
        guard let nextTheme = themes[safe: nextThemeIndex] else {
            return
        }

        updateSystemWithTheme(nextTheme)
    }

    // MARK: - Set A New Theme

    private func updateSystemWithTheme(_ theme: CalculatorTheme) {
        currentTheme = theme
        savedTheme = theme
        saveThemeToDisk(theme)
    }
}
