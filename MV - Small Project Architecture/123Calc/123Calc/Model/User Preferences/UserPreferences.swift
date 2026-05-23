//
//  UserPreferences.swift
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
//   It's a manager to interact with stored user preferences such as the current
//   colour theme used or the result from the last executed equation.
//   It's a simple wrapper for User Defaults.
//   Architectural Layer: The business logic layer (the main non-visual system).
//   Architecture Tip: We disconnect "how" the data is stored by creating this wrapper
//   around the UserDefaults data store, so that in the future it could be "swapped"
//   with something like SwiftData.
// --------------------------------------------------

import Foundation

struct UserPreferences {
    // MARK: - Unique Key

    let key: String

    // MARK: - Storing Data

    func set(_ value: Any) {
        // NOTE: UserDefaults is not a data store for actual data,
        // but rather somewhere to store what tab index the user selected
        // or some simple app-related information to restore on the next launch of the app.
        // Use SwiftData to store actual data such as received json from a server.
        UserDefaults.standard.set(value, forKey: key)
    }

    func getValue() -> Any? {
        UserDefaults.standard.object(forKey: key)
    }

    // MARK: - Deleting Data

    func deleteValue() {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
