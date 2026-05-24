//
//  UserPreferencesTests.swift
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
//   This file contains the unit tests, which execute on the components created within the
//   business logic layer of the app. We do not unit test the user interface (UI).
//   Write unit tests to ensure the actual output matches the expected output for all
//   possible known scenarios.
//   Architectural Layer: Unit tests.
// --------------------------------------------------

@testable import Calc123
import XCTest

class UserPreferencesTests: XCTestCase {
    // MARK: - System Under Test

    var sut: Calculator! // implicitly unwrapping this optional on each access of this property
    let userPreferenceKey = Calculator.keys.previousEquation
    
    // MARK: - Setup And Tear Down

    override func setUp() {
        let userPreference = UserPreference<Equation>(key: userPreferenceKey)
        sut = Calculator(userPreference)
    }

    override func tearDown() {
        sut = nil
    }

    // MARK: - Basic Math

    /// Test that the calculator logs the previous equation
    func testUserPreferenceRetrievesCorrectValue() throws {
        // user preferences should now store the last equation
        let userPreference = UserPreference<Equation>(key: userPreferenceKey)
        
        // 7 + 1 = 8
        sut.numberPressed(7); sut.addPressed(); sut.numberPressed(1); sut.equalsPressed()
        XCTAssertEqual(sut.result, Decimal(8))

        var previousEquation = userPreference.get()
        guard let previousResult = previousEquation?.result else {
            XCTFail("Failed to store result of previous equation")
            return
        }
        XCTAssertEqual(previousResult, Decimal(8))
        
        // 8 + 1 = 9
        sut.numberPressed(8); sut.addPressed(); sut.numberPressed(1); sut.equalsPressed()
        XCTAssertEqual(sut.result, Decimal(9))

        previousEquation = userPreference.get()
        guard let previousResult = previousEquation?.result else {
            XCTFail("Failed to store result of previous equation")
            return
        }
        XCTAssertEqual(previousResult, Decimal(9))
        
        // 9 + 1 = 10
        sut.numberPressed(9); sut.addPressed(); sut.numberPressed(1); sut.equalsPressed()
        XCTAssertEqual(sut.result, Decimal(10))
        
        previousEquation = userPreference.get()
        guard let previousResult = previousEquation?.result else {
            XCTFail("Failed to store result of previous equation")
            return
        }
        XCTAssertEqual(previousResult, Decimal(10))
    }
    
    
    func testThatCalculatorRevivesPreviousEquationOnLaunch() throws {
        // 9 + 1 = 10
        sut.numberPressed(9); sut.addPressed(); sut.numberPressed(1); sut.equalsPressed()
        XCTAssertEqual(sut.result, Decimal(10))
        self.tearDown() // simulate closing the app
        
        self.setUp() // simulate opening the app
        let _ = sut.restoreFromLastSession() // must call this function to trigger this feature
        XCTAssertEqual(sut.textToDisplay, "10")
        XCTAssertEqual(sut.result, Decimal(10))
    }
}
