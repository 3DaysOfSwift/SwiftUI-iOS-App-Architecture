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

    private let dataStore = DataStoreManager(key: ThemeManager.keys.dataStore)

    // MARK: - Theme Options

    private(set) var themes: [CalculatorTheme] = []

    // MARK: - Accessing The Current Theme

    private var savedTheme: CalculatorTheme?
    private(set) var currentTheme: CalculatorTheme
    
    // MARK: - Initialiser

    init() {
        currentTheme = themes.first ?? ThemeLoader().pinkTheme
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
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(theme) {
            dataStore.set(encoded)
        }
    }

    private func restoreSavedTheme() -> Bool {
        if let previousTheme = readSavedThemeFromDisk() {
            savedTheme = previousTheme
            return true
        }
        return false
    }

    private func readSavedThemeFromDisk() -> CalculatorTheme? {
        guard let savedTheme = dataStore.getValue() as? Data else {
            return nil
        }

        let decoder = JSONDecoder()
        return try? decoder.decode(CalculatorTheme.self, from: savedTheme)
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
        savedTheme = theme
        saveThemeToDisk(theme)
    }
}
