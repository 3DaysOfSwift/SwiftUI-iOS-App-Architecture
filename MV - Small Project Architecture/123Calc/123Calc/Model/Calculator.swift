//
//  Calculator.swift
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
//   The business logic layer for the calculator application.
// --------------------------------------------------

import Foundation
import Observation

// To prevent the class from being tightly-coupled to these concrete types we declared a convenience init function to be used for the usual setup for the model
extension Calculator {
    
    // here are the concrete types to be instantiated
    convenience init() {
        self.init {
            EquationBuilder(equation: Equation())
        }
    }
}

// We could name this class "Model" which represents the "System" or "thing" that models the behaviour without any UI connected to it.
// Model does not mean Data Model. It means the whole system / program that functions without UI.
@Observable
class Calculator: CalculatorAPI {
    // MARK: - Properties

    private(set) var history: [EquationRepresentable] = []
    private var equationBuilder: EquationBuilding
    private let equationBuilderProvider: () -> EquationBuilding

    // MARK: - Managers

    private let userPreferences = UserPreferences(key: Calculator.keys.previousEquation)

    // MARK: - Display

    private(set) var textToDisplay: String = "0"
    private func updateTextToDisplay() {
        textToDisplay = equationBuilder.textToDisplay
    }
    
    // MARK: - Properties For Testing

    var lhs: Decimal {
        equationBuilder.lhs
    }

    var rhs: Decimal? {
        equationBuilder.rhs
    }

    var operation: MathOperation? {
        equationBuilder.operation
    }

    // MARK: - Initialiser

    init(_ equationBuilder: @escaping (() -> EquationBuilding)) {
        equationBuilderProvider = equationBuilder
        self.equationBuilder = equationBuilder()
        
    }
    
    deinit {
        
    }

    // MARK: - Interaction API

    func clearHistory() {
        history = []
    }

    func clearPressed() {
        equationBuilder = equationBuilderProvider()
        updateTextToDisplay()
        deleteSavedSession()
    }

    func negatePressed() {
        populatePreviousResultIfNeeded(true)
        equationBuilder.negate()
        updateTextToDisplay()
    }

    func percentagePressed() {
        populatePreviousResultIfNeeded(true)
        equationBuilder.applyPercentage()
        updateTextToDisplay()
    }

    func decimalPressed() {
        if equationBuilder.isCompleted {
            equationBuilder = equationBuilderProvider()
        }
        equationBuilder.applyDecimalPoint()
        updateTextToDisplay()
    }

    var result: Decimal? {
        equationBuilder.result
    }

    // MARK: - Operations

    func addPressed() {
        commitAndPopulatePreviousResultIfNeeded()
        equationBuilder.add()
        updateTextToDisplay()
    }

    func minusPressed() {
        commitAndPopulatePreviousResultIfNeeded()
        equationBuilder.subtract()
        updateTextToDisplay()
    }

    func multiplyPressed() {
        commitAndPopulatePreviousResultIfNeeded()
        equationBuilder.multiply()
        updateTextToDisplay()
    }

    func dividePressed() {
        commitAndPopulatePreviousResultIfNeeded()
        equationBuilder.divide()
        updateTextToDisplay()
    }

    func equalsPressed() {
        if equationBuilder.isCompleted {
            var newEquationBuilder = equationBuilderProvider()
            newEquationBuilder.lhs = equationBuilder.result ?? Decimal.zero
            newEquationBuilder.operation = equationBuilder.operation
            newEquationBuilder.rhs = equationBuilder.rhs
            equationBuilder = newEquationBuilder
            updateTextToDisplay()
        }

        guard equationBuilder.isReadyToExecute else {
            return
        }

        executeEquation()
    }

    // MARK: - Equation Execution

    private func executeEquation() {
        equationBuilder.execute()
        updateTextToDisplay()
        appendToHistoryLog(equationBuilder)
        #if DEBUG
            printEquationToDebugConsole(equationBuilder)
        #endif
        saveSession()
    }

    private func appendToHistoryLog(_ equationBuilder: EquationBuilding) {
        guard equationBuilder.allowRecordingToTheHistoryLog else { return }
        history.append(equationBuilder.equation)
    }

    // MARK: - Print To Console

    private func printEquationToDebugConsole(_ equationBuilder: EquationBuilding) {
        print(equationBuilder.generatePrintout)
    }

    // MARK: - Number Input

    func numberPressed(_ number: Int) {
        // → Only accept values from the numeric keypad 0..9
        guard number <= 9,
              number >= 0 else { return }

        if equationBuilder.isCompleted {
            equationBuilder = equationBuilderProvider()
        }
        equationBuilder.enterNumber(number)
        updateTextToDisplay()
    }

    // MARK: - Business Logic & Behaviour

    private func commitCurrentEquationIfNeeded() -> Bool {
        if equationBuilder.isCompleted == false,
           equationBuilder.isReadyToExecute
        {
            executeEquation()
            return true
        }

        return false
    }

    private func populateEquationWithPreviousResult(_ continueEditingResult: Bool = false) {
        var newEquationBuilder = equationBuilderProvider()
        newEquationBuilder.lhs = equationBuilder.result ?? Decimal(0)

        if continueEditingResult == false {
            newEquationBuilder.startEditingRightHandSide()
        }
        equationBuilder = newEquationBuilder
        updateTextToDisplay()
    }

    private func commitAndPopulatePreviousResultIfNeeded(_ continueEditingResult: Bool = false) {
        // → Scenario 1: user enters 5 * 5 *
        if commitCurrentEquationIfNeeded() {
            populateEquationWithPreviousResult(continueEditingResult)
        }

        // → secanrio 2: user enters 5 * 5 = *
        if equationBuilder.isCompleted {
            populateEquationWithPreviousResult()
        }
    }

    private func populatePreviousResultIfNeeded(_ continueEditingResult: Bool = false) {
        if equationBuilder.isCompleted {
            populateEquationWithPreviousResult(continueEditingResult)
        }
    }

    // MARK: - Restoring Session

    func restoreFromLastSession() -> Bool {
        guard
            let lastExecutedEquation = readSavedEquationFromDisk(),
            let lastExecutedResult = lastExecutedEquation.result
        else {
            return false
        }

        var newEquationBuilder = equationBuilderProvider()
        newEquationBuilder.lhs = Decimal(1)
        newEquationBuilder.multiply()
        newEquationBuilder.rhs = lastExecutedResult
        newEquationBuilder.execute()
        equationBuilder = newEquationBuilder
        updateTextToDisplay()
        return true
    }

    private func saveSession() {
        guard equationBuilder.allowRecordingToTheHistoryLog else { return }

        guard
            isEquationSafeToBeSaved(equationBuilder) == true,
            equationBuilder.result?.isEqual(to: .zero) == false
        else {
            return
        }

        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(equationBuilder.equation) {
            userPreferences.set(encoded)
        }
    }

    private func deleteSavedSession() {
        userPreferences.deleteValue()
    }

    private func isEquationSafeToBeSaved(_ equationBuilder: EquationBuilding) -> Bool {
        guard equationBuilder.containsNans == false, // → prevent a runtime error when encoding nans
              let _ = equationBuilder.result,
              equationBuilder.isCompleted
        else {
            return false
        }
        return true
    }

    private func readSavedEquationFromDisk() -> Equation? {
        guard let savedEquation = userPreferences.getValue() as? Data else {
            return nil
        }

        let decoder = JSONDecoder()
        return try? decoder.decode(Equation.self, from: savedEquation)
    }

    // MARK: - Copy & Paste

    // → 💡 Tip: Adding system features like copy & paste provides a nicer experience for the user.

    func pasteInNumber(from decimal: Decimal) {
        if equationBuilder.isCompleted {
            equationBuilder = equationBuilderProvider()
        }

        equationBuilder.pasteIn(decimal)
        updateTextToDisplay()
    }

    func pasteInNumber(from mathEquation: EquationRepresentable) {
        guard let result = mathEquation.result else {
            return
        }

        equationBuilder = equationBuilderProvider()
        pasteInNumber(from: result)
    }
}
