//
//  DecimalTests.swift
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

class DecimalTests: XCTestCase {
    // MARK: - System Under Test

    var sut: Calculator! // implicitly unwrapping this optional on each access of this property

    // MARK: - Setup And Tear Down

    override func setUp() {
        let mockPreference = UserPreferenceMock<Equation>() // no storing to disk in these tests
        sut = Calculator(mockPreference)
    }

    override func tearDown() {
        sut = nil
    }

    // MARK: - Pressing Decimal Button - Left Hand Side Of Equation

    /// Test how the decimal button affects the equation. When pressed first before a numeric
    /// value the specified operand (left or right) will be set to zero.
    func testDecimalButtonWithZero_leftHandSideOfEquation() throws {
        // .
        sut.decimalPressed()
        XCTAssertEqual(sut.lhs, Decimal(0))
        XCTAssertEqual(sut.textToDisplay, "0.")

        // 0.
        sut.clearPressed()
        sut.numberPressed(0); sut.decimalPressed()
        XCTAssertEqual(sut.lhs, Decimal(0))
        XCTAssertEqual(sut.textToDisplay, "0.")

        // 0.0
        sut.clearPressed()
        sut.numberPressed(0); sut.decimalPressed(); sut.numberPressed(0)
        XCTAssertEqual(sut.lhs, Decimal(0))
        XCTAssertEqual(sut.textToDisplay, "0.0")

        // 0.00
        sut.clearPressed()
        sut.numberPressed(0); sut.decimalPressed(); sut.numberPressed(0); sut.numberPressed(0)
        XCTAssertEqual(sut.lhs, Decimal(0))
        XCTAssertEqual(sut.textToDisplay, "0.00")

        // 0.0.0
        sut.clearPressed()
        sut.numberPressed(0); sut.decimalPressed(); sut.numberPressed(0); sut.decimalPressed()
        XCTAssertEqual(sut.lhs, Decimal(0))
        XCTAssertEqual(sut.textToDisplay, "0.0")
    }

    // MARK: - Pressing Decimal Button - Right Hand Side Of Equation

    /// Test how the decimal button affects the equation. When pressed first before a numeric
    /// value the specified operand (left or right) will be set to zero.
    func testDecimalButtonWithZero_rightHandSideOfEquation() throws {
        // . + .
        sut.decimalPressed(); sut.addPressed(); sut.decimalPressed()
        XCTAssertEqual(sut.rhs, Decimal(0))
        XCTAssertEqual(sut.textToDisplay, "0.")

        // . + 0.
        sut.clearPressed()
        sut.decimalPressed(); sut.addPressed(); sut.numberPressed(0); sut.decimalPressed()
        XCTAssertEqual(sut.rhs, Decimal(0))
        XCTAssertEqual(sut.textToDisplay, "0.")

        // . + 0.0
        sut.clearPressed()
        sut.decimalPressed(); sut.addPressed(); sut.numberPressed(0); sut.decimalPressed(); sut.numberPressed(0)
        XCTAssertEqual(sut.rhs, Decimal(0))
        XCTAssertEqual(sut.textToDisplay, "0.0")

        // . + 0.00
        sut.clearPressed()
        sut.decimalPressed(); sut.addPressed(); sut.numberPressed(0); sut.decimalPressed(); sut.numberPressed(0); sut.numberPressed(0)
        XCTAssertEqual(sut.rhs, Decimal(0))
        XCTAssertEqual(sut.textToDisplay, "0.00")

        // . + 0.0.0
        sut.clearPressed()
        sut.decimalPressed(); sut.addPressed(); sut.numberPressed(0); sut.decimalPressed(); sut.numberPressed(0); sut.decimalPressed()
        XCTAssertEqual(sut.rhs, Decimal(0))
        XCTAssertEqual(sut.textToDisplay, "0.0")
    }

    // MARK: - Half Finished Decimal With Zeros - Left Hand Side Of Equation

    /// Test that the equation correctly represents an unfinished (half-entered) decimal with trailing zeros.
    /// From a mathematical point of view this will equate to zero, however the user is actually entering a
    /// decimal value - not zero.
    func testHalfFinishedDecimalWithZero_leftHandSideOfEquation() throws {
        // 0.00
        sut.numberPressed(0); sut.decimalPressed(); sut.numberPressed(0); sut.numberPressed(0)
        XCTAssertEqual(sut.lhs, Decimal(0))
        XCTAssertEqual(sut.textToDisplay, "0.00")

        // 0.000
        sut.clearPressed()
        sut.numberPressed(0); sut.decimalPressed(); sut.numberPressed(0); sut.numberPressed(0); sut.numberPressed(0)
        XCTAssertEqual(sut.lhs, Decimal(0))
        XCTAssertEqual(sut.textToDisplay, "0.000")

        // 0.0005
        sut.clearPressed()
        sut.numberPressed(0); sut.decimalPressed(); sut.numberPressed(0); sut.numberPressed(0); sut.numberPressed(0); sut.numberPressed(5)
        XCTAssertEqual(sut.lhs, Decimal(0.0005))
        XCTAssertEqual(sut.textToDisplay, "0.0005")
    }

    // MARK: - Half Finished Decimal With Zeros - Right Hand Side Of Equation

    /// Test that the equation correctly represents an unfinished (half-entered) decimal with trailing zeros.
    /// From a mathematical point of view this will equate to zero, however the user is actually entering a
    /// decimal value - not zero.
    func testHalfFinishedDecimalWithZero_rightHandSideOfEquation() throws {
        // 0 + 0.00
        sut.addPressed()
        sut.numberPressed(0); sut.decimalPressed(); sut.numberPressed(0); sut.numberPressed(0)
        XCTAssertEqual(sut.rhs, Decimal(0))
        XCTAssertEqual(sut.textToDisplay, "0.00")

        // 0 + 0.000
        sut.clearPressed(); sut.addPressed()
        sut.numberPressed(0); sut.decimalPressed(); sut.numberPressed(0); sut.numberPressed(0); sut.numberPressed(0)
        XCTAssertEqual(sut.rhs, Decimal(0))
        XCTAssertEqual(sut.textToDisplay, "0.000")

        // 0 + 0.0005
        sut.clearPressed(); sut.addPressed()
        sut.numberPressed(0); sut.decimalPressed(); sut.numberPressed(0); sut.numberPressed(0); sut.numberPressed(0); sut.numberPressed(5)
        XCTAssertEqual(sut.rhs, Decimal(0.0005))
        XCTAssertEqual(sut.textToDisplay, "0.0005")
    }

    // MARK: - Operands - Left Hand Side Of Equation

    /// Test the decimal value matches the value entered using the numeric keypad.
    func testDecimalInputOfLeftHandSideOfEquation() throws {
        // 0.123456789
        sut.numberPressed(0)
        sut.decimalPressed()
        sut.numberPressed(1)
        sut.numberPressed(2)
        sut.numberPressed(3)
        sut.numberPressed(4)
        sut.numberPressed(5)
        sut.numberPressed(6)
        sut.numberPressed(7)
        sut.numberPressed(8)
        sut.numberPressed(9)
        XCTAssertEqual(sut.lhs.formatted(), Decimal(0.123456789).formatted())
        XCTAssertEqual(sut.textToDisplay, "0.123457")
    }

    // MARK: - Operands - Right Hand Side Of Equation

    /// Test the decimal value matches the value entered using the numeric keypad.
    func testDecimalInputOfRightHandSideOfEquation() throws {
        // 0 + 0.123456789
        sut.numberPressed(0)
        sut.addPressed()

        sut.numberPressed(0)
        sut.decimalPressed()
        sut.numberPressed(1)
        sut.numberPressed(2)
        sut.numberPressed(3)
        sut.numberPressed(4)
        sut.numberPressed(5)
        sut.numberPressed(6)
        sut.numberPressed(7)
        sut.numberPressed(8)
        sut.numberPressed(9)
        XCTAssertEqual(sut.rhs?.formatted(), Decimal(0.123456789).formatted())
        XCTAssertEqual(sut.textToDisplay, "0.123457")
    }
}
