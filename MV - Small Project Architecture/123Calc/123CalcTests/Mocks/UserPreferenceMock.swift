//
//  MockUserPreference.swift
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
//   It's a "mock".
//   A mocked type is when you dont want to use the actual concrete implementation
//   and you want to control or even limit the internal activity that may happen within
//   the concrete implementation in testing.
//   For example, when this particular mock is used is because we dont want to actually
//   be storing to disk when we are testing the behaviour of the calculator and not wanting
//   the tests to be slowed down by writing to disk.
// --------------------------------------------------

import Foundation
@testable import Calc123

class UserPreferenceMock<T: Codable>: UserPreferenceStoring {
    
    // MARK: - Unique Key

    let key: String = ""
    private(set) var value: T?

    // MARK: - Storing Data

    func set(_ value: T) {
        self.value = value
    }

    func get() -> T? {
        return value
    }

    // MARK: - Deleting Data

    func delete() {
        value = nil
    }
}
