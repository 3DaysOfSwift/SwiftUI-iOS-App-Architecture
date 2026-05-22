//
//  Calculator.swift
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
//   It's the core of the calculator. The brain. It generates all of our behaviour.
//   Architectural Layer: Business Logic Layer
//
// -------------------------------------------------------------------------------------------

import Foundation

// We named this class AppBrain to represent the "Brain" of the app i.e. the "System" or "model" that defines the behaviour we want to model.
// 💡 Tip: "Model" does not mean "Data Model". It means, the "thing" that you could consider as the brain 🧠 of the system.

class AppBrain: ModelAPI {
    
    // MARK: - Feature objects
    // One feature manages and represents that "feature" of the software
    private(set) var calculator: any CalculatorFeature
    
    // MARK: - Initialization
    init(calculator: any CalculatorFeature) {
        self.calculator = calculator
    }
}
 
// MARK: - Convenient Setup
extension AppBrain {
    convenience init() {
        // Keywords: Dependency injection, IOC - inversion of control
        // For dependency injection we inject a closure to instantiate our concrete types
        let calculator = Calculator {
            EquationBuilder(equation: Equation())
        }
        self.init(calculator: calculator)
    }
}

