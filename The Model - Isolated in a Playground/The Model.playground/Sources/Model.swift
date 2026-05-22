import Foundation // Contains Decimal
import Darwin     // includes pow()

// MARK: - 📦 Layer 0 - Swift Language Extensions

extension Array {
    subscript (safe index: Int) -> Element? {
        (index >= 0 && count > index) ? self[index] : nil
    }
}

extension Decimal {
    var numberOfDecimalPlaces: Int {
        return max(-exponent, 0)
    }
}

// MARK: - 📦 Layer 1 - Equation

enum MathOperation {
    case add
    case subtract
    case multiply
    case divide
}

struct MathEquation {
    var leftHandSide: Decimal = 0
    var rightHandSide: Decimal?
    var operation: MathOperation?
    var result: Decimal?
    
    mutating func execute() -> Decimal? {
        if
            let operation = self.operation,
            let rightHandSide = self.rightHandSide {
            
            switch operation {
            case .add:
                result = leftHandSide + rightHandSide
            case .subtract:
                result = leftHandSide - rightHandSide
            case .multiply:
                result = leftHandSide * rightHandSide
            case .divide:
                result = leftHandSide / rightHandSide
            }
            return result
        }
        return nil
    }
}

// MARK: - 📦 Layer 2 - EquationBuilder

class EquationBuilder {

    enum KeyPadInput: Int {
        case zero = 0
        case one = 1
        case two = 2
        case three = 3
        case four = 4
        case five = 5
        case six = 6
        case seven = 7
        case eight = 8
        case nine = 9
    }
    
    enum OperandSide {
        case leftHandSide
        case rightHandSide
    }
    
    private(set) var equation = MathEquation()
    private var editingSide: OperandSide = .leftHandSide
    private(set) var isEnteringDecimal = false
    private(set) var currentDecimalPlaces = 0
    var result: Decimal? {
        return equation.result
    }
    var leftHandOperand: Decimal {
        return equation.leftHandSide
    }
    var rightHandOperand: Decimal? {
        return equation.rightHandSide
    }
    
    init() {
        
    }

    init (_ equation: MathEquation) {
        self.equation = equation
        if equation.operation != nil {
            editingSide = .rightHandSide
        }
        
        if let rhs = equation.rightHandSide {
            currentDecimalPlaces = rhs.numberOfDecimalPlaces
        } else {
            currentDecimalPlaces = equation.leftHandSide.numberOfDecimalPlaces
        }
        isEnteringDecimal  = currentDecimalPlaces > 0 ? true : false
    }
    
    func decimalPressed() {
        isEnteringDecimal = true
        if editingSide == .rightHandSide,
           equation.rightHandSide == nil
        {
            equation.rightHandSide = Decimal(0)
        }
    }

    func selectOperation(operation: MathOperation) {
        equation.operation = operation
        editingSide = .rightHandSide
        currentDecimalPlaces = 0
        isEnteringDecimal = false
        startEditingRightHandSide()
    }

    func execute() {
        equation.execute()
    }
    
    func enterNumber(_ number: KeyPadInput) {
        switch editingSide {
        case .leftHandSide:
            let previousInput = equation.leftHandSide
            equation.leftHandSide = appendNewNumber(number.rawValue, toPreviousEntry: previousInput)
        case .rightHandSide:
            let previousInput = equation.rightHandSide ?? Decimal.zero
            equation.rightHandSide = appendNewNumber(number.rawValue, toPreviousEntry: previousInput)
        }
    }

    private func appendNewNumber(_ number: Int, toPreviousEntry previousInput: Decimal) -> Decimal {
        guard isEnteringDecimal == false else {
            return appendNewDecimal(number, toPreviousEntry: previousInput)
        }
        // shift existing base 10 numbers left by column (* 10)
        return (previousInput * 10) + Decimal(number)
    }

    private func appendNewDecimal(_ number: Int, toPreviousEntry previousInput: Decimal) -> Decimal {
        currentDecimalPlaces += 1
        let base10Column = Decimal(pow(10.0, Double(currentDecimalPlaces)))
        let newDecimalNumber = Decimal(number) / base10Column
        return previousInput + newDecimalNumber
    }

    private func startEditingRightHandSide() {
        editingSide = .rightHandSide
        isEnteringDecimal = false
        currentDecimalPlaces = 0
    }
}

// MARK: - 📦 Layer 3 - Calculator

class Calculator {
    private var equationBuilder: EquationBuilder = EquationBuilder()
    private(set) var historicalLog: [MathEquation] = []
    var result: Decimal? {
        return equationBuilder.result
    }
    var leftHandOperand: Decimal {
        return equationBuilder.leftHandOperand
    }
    var rightHandOperand: Decimal? {
        return equationBuilder.rightHandOperand
    }
    
    func clear() -> String {
        equationBuilder = EquationBuilder()
        return textToDisplay
    }
    
    func enterDecimalState() -> String {
        equationBuilder.decimalPressed()
        return textToDisplay
    }
    
    func enterZero() -> String {
        equationBuilder.enterNumber(.zero)
        return textToDisplay
    }
    
    func enterOne() -> String {
        equationBuilder.enterNumber(.one)
        return textToDisplay
    }
    
    func enterTwo() -> String {
        equationBuilder.enterNumber(.two)
        return textToDisplay
    }
    
    func enterThree() -> String {
        equationBuilder.enterNumber(.three)
        return textToDisplay
    }
    
    func enterFour() -> String {
        equationBuilder.enterNumber(.four)
        return textToDisplay
    }
    
    func enterFive() -> String {
        equationBuilder.enterNumber(.five)
        return textToDisplay
    }
    
    func enterSix() -> String {
        equationBuilder.enterNumber(.six)
        return textToDisplay
    }
    
    func enterSeven() -> String {
        equationBuilder.enterNumber(.seven)
        return textToDisplay
    }
    
    func enterEight() -> String {
        equationBuilder.enterNumber(.eight)
        return textToDisplay
    }
    
    func enterNine() -> String {
        equationBuilder.enterNumber(.nine)
        return textToDisplay
    }
    
    func add() -> String {
        equationBuilder.selectOperation(operation: .add)
        return textToDisplay
    }
    
    func subtract() -> String {
        equationBuilder.selectOperation(operation: .subtract)
        return textToDisplay
    }
    
    func multiply() -> String {
        equationBuilder.selectOperation(operation: .multiply)
        return textToDisplay
    }
    
    func division() -> String {
        equationBuilder.selectOperation(operation: .divide)
        return textToDisplay
    }
    
    func execute() -> String {
        if equationBuilder.result == nil {
            equationBuilder.execute()
            historicalLog.append(equationBuilder.equation)
        }
        
        return textToDisplay
    }
    
    func reviveHistoricalEquation(atIndex index: Int) {
        if let previousEquation = historicalLog[safe: index] {
            equationBuilder = EquationBuilder(previousEquation)
        }
    }
}

// MARK: Visual Display for Xcode Playground
extension Calculator {
    
    private var localizedDecimalSymbol: String {
        // changes in different countries
        return Locale.current.decimalSeparator ?? "."
    }
    
    var textToDisplay: String {
        // display the final result
        if let result = self.result {
            return result.formatted()
        }
        
        // No result: Display the operand being entered
        let currentDecimalPlaces = equationBuilder.currentDecimalPlaces
        let isEnteringDecimal = equationBuilder.isEnteringDecimal
        
        // Try the right hand side operand first
        if let rightHandOperand = self.rightHandOperand {
            return formatOperandForDisplay(rightHandOperand, isEnteringDecimal: isEnteringDecimal, numberOfTrailingZerosToPrint: currentDecimalPlaces - rightHandOperand.numberOfDecimalPlaces)
        }
        
        // No right hand side operand: So display the left hand side operand
        return formatOperandForDisplay(leftHandOperand, isEnteringDecimal: isEnteringDecimal, numberOfTrailingZerosToPrint: currentDecimalPlaces - leftHandOperand.numberOfDecimalPlaces)
    }
    
    /**
    This method exists to solve the following problem; Imagine the user enters 1. or 1.00. In this scenario we would NOT want to display 1 or 1.0 to the user. Instead, we want to display the values entered which can no longer be represented numerically
     */
    private func formatOperandForDisplay(_ decimal: Decimal, isEnteringDecimal: Bool, numberOfTrailingZerosToPrint: Int) -> String {
        guard decimal.isNaN == false else {
            return "NaN"
        }
        
        let formattedNumber = decimal.formatted()
        guard isEnteringDecimal else {
            return formattedNumber
        }

        var displayText = applyDecimalToStringIfNeeded(formattedNumber)
        for _ in 0..<numberOfTrailingZerosToPrint {
            displayText.append("0")
        }
        return displayText
    }

    private func applyDecimalToStringIfNeeded(_ string: String) -> String {
        let decimalSymbol = localizedDecimalSymbol
        if string.contains(decimalSymbol) {
            return string
        }
        return string.appending(decimalSymbol)
    }
}
