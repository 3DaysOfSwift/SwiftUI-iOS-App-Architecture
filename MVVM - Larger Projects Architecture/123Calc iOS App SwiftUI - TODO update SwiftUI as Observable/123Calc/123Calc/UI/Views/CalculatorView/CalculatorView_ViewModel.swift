//
//  ReactiveCalculator.swift
//  123Calc
//
//  Created by 3DaysOfSwift.com on 23/09/2025.
//
//  3DaysOfSwift.com                → All rights reserved
//  Website                         → https://www.3DaysOfSwift.com
//
//  We 🧡 Swift
//  Welcome to our community of 3DaysOfSwift.com developers!
//
//  🧕🏻🙋🏽‍♂️👨🏿‍💼👩🏼‍💼👩🏻‍💻💁🏼‍♀️👨🏼‍💼🙋🏻‍♂️🙋🏻‍♀️👩🏼‍💻🙋🏿💁🏽‍♂️🙋🏽‍♀️🙋🏿‍♀️🧕🏾🙋🏼‍♂️
// -------------------------------------------------------------------------------------------
//
// → What's This File?
//   It's a class created to be an adapter between the Calculator system and the reactive
//   SwiftUI framework in order to automatically trigger our SwiftUI Views to redraw
//   themselves.
//   Architectural Layer: The user interface (UI) of the app.
//
// -------------------------------------------------------------------------------------------

import Foundation

class CalculatorView_ViewModel: ObservableObject {
    // we chose to tightly couple the ViewModels with the App & Model (which is the whole system)
    // we do this for convenience and it also solves many issues with modern-day iOS Architecture
    private let calc: CalculatorFeature = Calc123App().model.calculator // uses the shared instance stored as an environment variable in the main App struct

    @Published private(set) var textToDisplay: String = ""
    
    init() {
        self.textToDisplay = calc.textToDisplay
    }

    func clearPressed() {
        calc.clearPressed()
        textToDisplay = calc.textToDisplay
    }

    func negatePressed() {
        calc.negatePressed()
        textToDisplay = calc.textToDisplay
    }

    func percentagePressed() {
        calc.percentagePressed()
        textToDisplay = calc.textToDisplay
    }

    func numberPressed(_ number: Int) {
        calc.numberPressed(number)
        textToDisplay = calc.textToDisplay
    }

    func decimalPressed() {
        calc.decimalPressed()
        textToDisplay = calc.textToDisplay
    }

    func addPressed() {
        calc.addPressed()
        textToDisplay = calc.textToDisplay
    }

    func minusPressed() {
        calc.minusPressed()
        textToDisplay = calc.textToDisplay
    }

    func multiplyPressed() {
        calc.multiplyPressed()
        textToDisplay = calc.textToDisplay
    }

    func dividePressed() {
        calc.dividePressed()
        textToDisplay = calc.textToDisplay
    }

    func equalsPressed() {
        calc.equalsPressed()
        textToDisplay = calc.textToDisplay
    }

    func restoreFromLastSession() -> Bool {
        let result =  calc.restoreFromLastSession()
        textToDisplay = calc.textToDisplay
        return result
    }

    var history: [EquationRepresentable] {
        calc.history
    }

    func pasteInNumber(from decimal: Decimal) {
        calc.pasteInNumber(from: decimal)
        textToDisplay = calc.textToDisplay
    }

    func pasteInNumber(from mathEquation: EquationRepresentable) {
        calc.pasteInNumber(from: mathEquation)
        textToDisplay = calc.textToDisplay
    }

    var rhs: Decimal? {
        calc.rhs
    }

    var lhs: Decimal {
        calc.lhs
    }

    var operation: MathOperation? {
        calc.operation
    }
}
