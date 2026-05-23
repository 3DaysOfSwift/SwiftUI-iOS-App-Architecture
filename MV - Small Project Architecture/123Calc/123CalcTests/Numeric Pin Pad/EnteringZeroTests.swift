//
//  EnteringZeroTests.swift
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

class EnteringZeroTests: XCTestCase {
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

    // MARK: - Operands - Left Hand Side Of Equation

    /// Test entering 0 into the left hand side of the equation.
    func testEntering0_leftHandSideOfEquation() throws {
        // 0
        sut.numberPressed(0)

        XCTAssertEqual(sut.lhs, Decimal(0))
        XCTAssertEqual(sut.textToDisplay, "0")
    }

    /// Test entering 00 into the left hand side of the equation.
    func testEntering00_leftHandSideOfEquation() throws {
        // 00
        sut.numberPressed(0)
        sut.numberPressed(0)

        XCTAssertEqual(sut.lhs, Decimal(0))
        XCTAssertEqual(sut.textToDisplay, "0")
    }

    /// Test entering 000 into the left hand side of the equation.
    func testEntering000_leftHandSideOfEquation() throws {
        // 000
        sut.numberPressed(0)
        sut.numberPressed(0)
        sut.numberPressed(0)

        XCTAssertEqual(sut.lhs, Decimal(0))
        XCTAssertEqual(sut.textToDisplay, "0")
    }

    // MARK: - Operands - Right Hand Side Of Equation

    /// Test entering 0 into the right hand side of the equation.
    func testEntering0_rightHandSideOfEquation() throws {
        // 0 + 0
        sut.numberPressed(0)
        sut.addPressed()
        sut.numberPressed(0)

        XCTAssertEqual(sut.rhs, Decimal(0))
        XCTAssertEqual(sut.textToDisplay, "0")
    }

    /// Test entering 00 into the right hand side of the equation.
    func testEntering00_rightHandSideOfEquation() throws {
        // 0 + 00
        sut.numberPressed(0)
        sut.addPressed()
        sut.numberPressed(0)
        sut.numberPressed(0)

        XCTAssertEqual(sut.rhs, Decimal(0))
        XCTAssertEqual(sut.textToDisplay, "0")
    }

    /// Test entering 000 into the right hand side of the equation.
    func testEntering000_rightHandSideOfEquation() throws {
        // 0 + 000
        sut.numberPressed(0)
        sut.addPressed()
        sut.numberPressed(0)
        sut.numberPressed(0)
        sut.numberPressed(0)

        XCTAssertEqual(sut.rhs, Decimal(0))
        XCTAssertEqual(sut.textToDisplay, "0")
    }

    // MARK: - Math With Zero

    /// Test adding 000 to 000.
    func test000Addition() throws {
        // 000 + 000 = 0
        sut.numberPressed(0)
        sut.numberPressed(0)
        sut.numberPressed(0)
        sut.addPressed()
        sut.numberPressed(0)
        sut.numberPressed(0)
        sut.numberPressed(0)
        sut.equalsPressed()

        XCTAssertEqual(sut.lhs, Decimal(0))
        XCTAssertEqual(sut.rhs, Decimal(0))
        XCTAssertEqual(sut.result, Decimal(0))
        XCTAssertEqual(sut.textToDisplay, "0")
    }

    /// Test subtracting 000 from 000.
    func test000Subtraction() throws {
        // 000 - 000 = 0
        sut.numberPressed(0)
        sut.numberPressed(0)
        sut.numberPressed(0)
        sut.minusPressed()
        sut.numberPressed(0)
        sut.numberPressed(0)
        sut.numberPressed(0)
        sut.equalsPressed()

        XCTAssertEqual(sut.lhs, Decimal(0))
        XCTAssertEqual(sut.rhs, Decimal(0))
        XCTAssertEqual(sut.result, Decimal(0))
        XCTAssertEqual(sut.textToDisplay, "0")
    }

    /// Test dividing 000 by 000. In mathematics dividing by zero is not a valid operation and results in a nan (not a number).
    func test000Division() throws {
        // 000 / 000 = not a number (nan). Cannot divide by zero in mathematics
        sut.numberPressed(0)
        sut.numberPressed(0)
        sut.numberPressed(0)
        sut.dividePressed()
        sut.numberPressed(0)
        sut.numberPressed(0)
        sut.numberPressed(0)
        sut.equalsPressed()

        XCTAssertEqual(sut.lhs, Decimal(0))
        XCTAssertEqual(sut.rhs, Decimal(0))
        XCTAssertEqual(sut.result, Decimal.nan)
        XCTAssertEqual(sut.textToDisplay, "Error")
    }

    /// Test multiplying 000 by 000.
    func test000Multiplication() throws {
        // 000 * 000 = 0
        sut.numberPressed(0)
        sut.numberPressed(0)
        sut.numberPressed(0)
        sut.multiplyPressed()
        sut.numberPressed(0)
        sut.numberPressed(0)
        sut.numberPressed(0)
        sut.equalsPressed()

        XCTAssertEqual(sut.lhs, Decimal(0))
        XCTAssertEqual(sut.rhs, Decimal(0))
        XCTAssertEqual(sut.result, Decimal(0))
        XCTAssertEqual(sut.textToDisplay, "0")
    }
}
