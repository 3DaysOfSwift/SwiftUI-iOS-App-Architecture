//
//  DecimalMathTests.swift
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

class DecimalMathTests: XCTestCase {
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

    // MARK: - Basic Math

    /// Test basic addition using decimals.
    func testDecimalAddition() throws {
        // 0.6 + 0.4 = 1
        sut.numberPressed(0)
        sut.decimalPressed()
        sut.numberPressed(6)

        sut.addPressed()

        sut.numberPressed(0)
        sut.decimalPressed()
        sut.numberPressed(4)
        sut.equalsPressed()

        XCTAssertEqual(sut.lhs, Decimal(0.6))
        XCTAssertEqual(sut.rhs, Decimal(0.4))
        XCTAssertEqual(sut.result, Decimal(1))
        XCTAssertEqual(sut.textToDisplay, "1")
    }

    /// Test basic subtraction using decimals.
    func testDecimalSubtraction() throws {
        // 0.9 - 0.7 = 0.2
        sut.numberPressed(0)
        sut.decimalPressed()
        sut.numberPressed(9)

        sut.minusPressed()

        sut.numberPressed(0)
        sut.decimalPressed()
        sut.numberPressed(7)
        sut.equalsPressed()

        XCTAssertEqual(sut.lhs, Decimal(0.9))
        XCTAssertEqual(sut.rhs, Decimal(0.7))
        XCTAssertEqual(sut.result, Decimal(0.2))
        XCTAssertEqual(sut.textToDisplay, "0.2")
    }
}
