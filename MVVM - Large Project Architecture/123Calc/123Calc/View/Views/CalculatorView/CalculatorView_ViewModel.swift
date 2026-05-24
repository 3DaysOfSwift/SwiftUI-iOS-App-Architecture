//
//  CalculatorView_ViewModel.swift
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
//   This file adapts the calculator model for the calculator view.
//   Architectural Layer: The view model between the user interface and model.
// --------------------------------------------------

import Foundation

final class CalculatorView_ViewModel: ObservableObject { // Remember, this is the ViewModel of the CalculatorView
    
    // MARK: - Model
    
    private var calc: Calculator {
        Calculator.shared
    }
    
    // MARK: - Display
    
    @Published private(set) var textToDisplay: String
    
    // MARK: - Initialiser
    
    init() {
        textToDisplay = Calculator.shared.textToDisplay
    }
    
    private func syncDisplayWithModel() {
        textToDisplay = calc.textToDisplay
    }
    
    // MARK: - Interaction API
    
    func clearPressed() {
        calc.clearPressed()
        syncDisplayWithModel()
    }
    
    func negatePressed() {
        calc.negatePressed()
        syncDisplayWithModel()
    }
    
    func percentagePressed() {
        calc.percentagePressed()
        syncDisplayWithModel()
    }
    
    func decimalPressed() {
        calc.decimalPressed()
        syncDisplayWithModel()
    }
    
    func numberPressed(_ number: Int) {
        calc.numberPressed(number)
        syncDisplayWithModel()
    }
    
    func addPressed() {
        calc.addPressed()
        syncDisplayWithModel()
    }
    
    func minusPressed() {
        calc.minusPressed()
        syncDisplayWithModel()
    }
    
    func multiplyPressed() {
        calc.multiplyPressed()
        syncDisplayWithModel()
    }
    
    func dividePressed() {
        calc.dividePressed()
        syncDisplayWithModel()
    }
    
    func equalsPressed() {
        calc.equalsPressed()
        syncDisplayWithModel()
    }
}

