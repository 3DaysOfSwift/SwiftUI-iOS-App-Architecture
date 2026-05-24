//
//  UserPreference.swift
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

protocol UserPreferenceStoring<T> {
    associatedtype T: Codable
    
    func set(_ value: T)

    func get() -> T?

    func delete()
}

struct UserPreference<T: Codable>: UserPreferenceStoring {
    
    // MARK: - Unique Key

    let key: String

    // MARK: - Storing Data

    func set(_ value: T) {
        // NOTE: UserDefaults is not a data store for actual data,
        // but rather somewhere to store user preferences like a selected tab bar index
        // or some simple app-related information to restore on the next launch of the app.
        // Use SwiftData to store actual data such as received json from a server.
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(value) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }

    func get() -> T? {
        guard let value = UserDefaults.standard.object(forKey: key) as? Data else {
            return nil
        }
        let decoder = JSONDecoder()
        return try? decoder.decode(T.self, from: value)
    }

    // MARK: - Deleting Data

    func delete() {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
