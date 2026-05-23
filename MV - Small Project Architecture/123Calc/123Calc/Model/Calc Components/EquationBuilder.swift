//
//  EquationBuilder.swift
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
//   It's a manager for one equation. In charge of input and what is displayed to the user.
//   Architectural Layer: Business Logic Layer
// --------------------------------------------------

import Foundation

// MARK: - Protocol

protocol EquationBuilding {
    var result: Decimal? { get }
    func negate()
    func applyPercentage()
    func enterNumber(_ number: Int)
    func applyDecimalPoint()
    func add()
    func subtract()
    func multiply()
    func divide()
    func execute()

    var textToDisplay: String { get }
    var rhs: Decimal? { get set }
    var lhs: Decimal { get set }
    var operation: MathOperation? { get set }
    var isCompleted: Bool { get }
    var isReadyToExecute: Bool { get }

    var allowRecordingToTheHistoryLog: Bool { get }
    var equation: EquationRepresentable { get }

    var generatePrintout: String { get }

    func startEditingRightHandSide()

    var containsNans: Bool { get }

    func pasteIn(_ decimal: Decimal)
}

// MARK: - EquationBuilder

class EquationBuilder: EquationBuilding {
    // MARK: - Operation Side Enum

    enum OperandSide {
        case leftHandSide
        case rightHandSide
    }

    // MARK: - Constants

    private let decimalSymbol = Locale.current.decimalSeparator ?? "."
    private let groupingSymbol = Locale.current.groupingSeparator ?? ","
    private let minusSymbol = "-"
    private let errorMessage = "Error"

    // MARK: - variables

    private(set) var equation: EquationRepresentable
    private var editingSide: OperandSide = .leftHandSide
    private var isEnteringDecimal = false
    private var currentDecimalPlaces = 1
    private var needsNegating: OperandSide?

    // MARK: - Display

    private(set) var textToDisplay = "" // NOTE: This is not UI, but the string value representing the current value being entered or the result being presented. This is data and not UI.

    private func formatForTextToDisplay(_ decimal: Decimal?) -> String {
        guard decimal?.isNaN == false else { return errorMessage }
        return decimal?.formatted() ?? errorMessage
    }

    private func formatAppendingGhostZerosForDisplayText(_ decimal: Decimal, _ decimalPlaces: Int) -> String {
        guard decimal.isNaN == false else {
            return errorMessage
        }

        let formattedBeginning = decimal.formatted()
        let formattedBeginningWithDecimal = applyDecimalToStringIfNeeded(formattedBeginning)
        guard let numberOfExistingDecimalPlaces = formattedBeginningWithDecimal.components(separatedBy: decimalSymbol).last?.count else {
            return errorMessage
        }

        var displayText = formattedBeginningWithDecimal
        let numberOfZerosToPrint = decimalPlaces - numberOfExistingDecimalPlaces
        for _ in 0 ..< numberOfZerosToPrint {
            displayText.append("0")
        }
        return displayText
    }

    // MARK: - Record Equation In System

    var allowRecordingToTheHistoryLog = true

    // MARK: - Initialiser

    init(equation: EquationRepresentable) {
        self.equation = equation
        textToDisplay = formatForTextToDisplay(equation.lhs)
    }

    // MARK: - Completed Equation

    var isCompleted: Bool {
        return equation.executed
    }

    var isReadyToExecute: Bool {
        guard equation.executed == false else {
            return false
        }

        if let _ = operation,
           let _ = rhs
        {
            return true
        }

        return false
    }

    var containsNans: Bool {
        lhs.isNaN || (rhs?.isNaN ?? false) || (result?.isNaN ?? false)
    }

    // MARK: - Extra Functions

    func negate() {
        guard isCompleted == false else { return }

        switch editingSide {
        case .leftHandSide:
            equation.negateLeftHandSide()
            displayNegateSymbolOnDisplay(lhs)
        case .rightHandSide:
            equation.negateRightHandSide()
            displayNegateSymbolOnDisplay(rhs)
        }
    }

    private func displayNegateSymbolOnDisplay(_ decimal: Decimal?) {
        guard let decimal = decimal else { return }

        if decimal.isSignMinus {
            textToDisplay.addPrefixIfNeeded(minusSymbol)
        } else {
            textToDisplay.removePrefixIfNeeded(minusSymbol)
        }
    }

    func applyPercentage() {
        guard isCompleted == false else { return }

        switch editingSide {
        case .leftHandSide:
            equation.applyPercentageToLeftHandSide()
            textToDisplay = formatForTextToDisplay(lhs)
        case .rightHandSide:
            guard let _ = rhs else { return }
            equation.applyPercentageToRightHandSide()
            textToDisplay = formatForTextToDisplay(rhs)
        }
    }

    func applyDecimalPoint() {
        guard isCompleted == false else { return }
        isEnteringDecimal = true

        if editingSide == .rightHandSide,
           rhs == nil
        {
            rhs = Decimal(0)
        }

        textToDisplay = applyDecimalToStringIfNeeded(textToDisplay)
    }

    private func applyDecimalToStringIfNeeded(_ string: String) -> String {
        if string.contains(decimalSymbol) {
            return string
        }
        return string.appending(decimalSymbol)
    }

    // MARK: - Math Operations

    func divide() {
        guard isCompleted == false else { return }
        operation = .divide
        startEditingRightHandSide()
    }

    func add() {
        guard isCompleted == false else { return }
        operation = .add
        startEditingRightHandSide()
    }

    func subtract() {
        guard isCompleted == false else { return }
        operation = .subtract
        startEditingRightHandSide()
    }

    func multiply() {
        guard isCompleted == false else { return }
        operation = .multiply
        startEditingRightHandSide()
    }

    func execute() {
        guard isCompleted == false else { return }
        equation.execute()
        textToDisplay = formatForTextToDisplay(equation.result)
    }

    func enterNumber(_ number: Int) {
        guard isCompleted == false else { return }

        switch editingSide {
        case .leftHandSide:
            let tuple = appendNewNumber(number, toPreviousEntry: lhs)
            lhs = tuple.decimal
            textToDisplay = tuple.stringRepresentation

        case .rightHandSide:
            let tuple = appendNewNumber(number, toPreviousEntry: rhs ?? Decimal.zero)
            rhs = tuple.decimal
            textToDisplay = tuple.stringRepresentation
        }
    }

    private func appendNewNumber(_ number: Int, toPreviousEntry previousInput: Decimal) -> (decimal: Decimal, stringRepresentation: String) {
        guard isEnteringDecimal == false else {
            return appendNewDecimal(number, toPreviousEntry: previousInput)
        }
        let decimal = (previousInput * 10) + Decimal(number)
        return (decimal, formatForTextToDisplay(decimal))
    }

    private func appendNewDecimal(_ number: Int, toPreviousEntry previousInput: Decimal) -> (decimal: Decimal, stringRepresentation: String) {
        let newDecimalNumber = Decimal(number) / Decimal(pow(10.0, Double(currentDecimalPlaces)))
        currentDecimalPlaces += 1
        let decimal = previousInput + newDecimalNumber

        // handle a special case where the user is entering trailing zeros i.e. "0.0000" to write "1.00005". It's an unfinished decimal!
        let needsToPrintGhostZeros = number == 0
        if needsToPrintGhostZeros {
            return (decimal, formatAppendingGhostZerosForDisplayText(decimal, currentDecimalPlaces - 1))
        }
        return (decimal, formatForTextToDisplay(decimal))
    }

    // MARK: - Copy & Paste

    func pasteIn(_ decimal: Decimal) {
        switch editingSide {
        case .leftHandSide: lhs = decimal
        case .rightHandSide: rhs = decimal
        }
    }

    // MARK: - Print Description

    var generatePrintout: String {
        return equation.generatePrintout()
    }

    // MARK: - Set LHS & RHS Values

    var lhs: Decimal {
        get {
            return equation.lhs
        }
        set {
            equation.lhs = newValue
            textToDisplay = formatForTextToDisplay(newValue)
        }
    }

    var rhs: Decimal? {
        get {
            return equation.rhs
        }
        set {
            guard let decimal = newValue else {
                return
            }
            equation.rhs = decimal
            startEditingRightHandSide()
            textToDisplay = formatForTextToDisplay(decimal)
        }
    }

    var result: Decimal? {
        return equation.result
    }

    var operation: MathOperation? {
        get {
            return equation.operation
        }
        set {
            guard let operation = newValue else {
                return
            }
            equation.operation = operation
            startEditingRightHandSide()
            isEnteringDecimal = false
        }
    }

    func startEditingRightHandSide() {
        guard editingSide != .rightHandSide else { return }
        editingSide = .rightHandSide
        isEnteringDecimal = false
        currentDecimalPlaces = 1
    }
}
