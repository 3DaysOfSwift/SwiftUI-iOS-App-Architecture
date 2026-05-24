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

// NOTE: Calculator uses dependency injection to be initialized, which is a good architectural decision, but also makes it difficult to understand how to properly instantiate the class. It also feels a bit weird and perhaps over-the-top too. To make life easier and to simplify the code, we added a convenience init function to be used for standard setup for the model. i.e. Calculator() can now be used outside of testing and injecting in different dependencies.
extension Calculator {
    
    convenience init() {
        let userPreference = UserPreference<Equation>(key: Calculator.keys.previousEquation)
        self.init(userPreference)
    }
}

// We could name this class "Model" which represents the "System" or "thing" that models the behaviour of the entire program without any UI connected to it.
// Model does not mean Data Model. It means the whole system or non-UI program that functions without any visual representation.
@Observable
class Calculator: CalculatorAPI {
    
    // MARK: - Properties

    private(set) var history: [Equation] = []
    private var equationBuilder: EquationBuilder

    // MARK: - Managers

    private let userPreferenceForLastEquation: any UserPreferenceStoring<Equation>

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

    init(_ userPreference: any UserPreferenceStoring<Equation>) {
        self.userPreferenceForLastEquation = userPreference
        self.equationBuilder = EquationBuilder(equation: Equation())
    }
    
    deinit {
        
    }
    
    private func newEquationBuilder() -> EquationBuilder {
        // Tip: 💡 One line expressions dont have to explicitly use the return keyword. The compiler adds it.
        EquationBuilder(equation: Equation())
    }
    
    // MARK: - Interaction API

    func clearHistory() {
        history = []
    }

    func clearPressed() {
        equationBuilder = newEquationBuilder()
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
            equationBuilder = newEquationBuilder()
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
            let newEquationBuilder = newEquationBuilder()
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

    private func appendToHistoryLog(_ equationBuilder: EquationBuilder) {
        guard equationBuilder.allowRecordingToTheHistoryLog else { return }
        history.append(equationBuilder.equation)
    }

    // MARK: - Print To Console

    private func printEquationToDebugConsole(_ equationBuilder: EquationBuilder) {
        print(equationBuilder.generatePrintout)
    }

    // MARK: - Number Input

    func numberPressed(_ number: Int) {
        // → Only accept values from the numeric keypad 0..9
        guard number <= 9,
              number >= 0 else { return }

        if equationBuilder.isCompleted {
            equationBuilder = newEquationBuilder()
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
        let newEquationBuilder = newEquationBuilder()
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

        let newEquationBuilder = newEquationBuilder()
        newEquationBuilder.lhs = Decimal(1)
        newEquationBuilder.multiply()
        newEquationBuilder.rhs = lastExecutedResult
        newEquationBuilder.execute()
        equationBuilder = newEquationBuilder
        updateTextToDisplay()
        return true
    }

    private func saveSession() {
        guard
            equationBuilder.allowRecordingToTheHistoryLog,
            isEquationSafeToBeSaved(equationBuilder) == true,
            equationBuilder.result?.isEqual(to: .zero) == false
        else {
            return
        }

        userPreferenceForLastEquation.set(equationBuilder.equation)
    }

    private func deleteSavedSession() {
        userPreferenceForLastEquation.delete()
    }

    private func isEquationSafeToBeSaved(_ equationBuilder: EquationBuilder) -> Bool {
        guard equationBuilder.containsNans == false, // → prevent a runtime error when encoding nans
              let _ = equationBuilder.result,
              equationBuilder.isCompleted
        else {
            return false
        }
        return true
    }

    private func readSavedEquationFromDisk() -> Equation? {
        userPreferenceForLastEquation.get()
    }

    // MARK: - Copy & Paste

    // → 💡 Tip: Adding system features like copy & paste provides a nicer experience for the user.

    func pasteInNumber(from decimal: Decimal) {
        if equationBuilder.isCompleted {
            equationBuilder = newEquationBuilder()
        }

        equationBuilder.pasteIn(decimal)
        updateTextToDisplay()
    }

    func pasteInNumber(from mathEquation: Equation) {
        guard let result = mathEquation.result else {
            return
        }

        equationBuilder = newEquationBuilder()
        pasteInNumber(from: result)
    }
}
