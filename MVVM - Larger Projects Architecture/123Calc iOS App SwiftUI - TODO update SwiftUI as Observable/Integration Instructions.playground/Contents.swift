//: ## ![3DaysOfSwift.com Logo](Header.png) Integration Instructions
//: © copyright of [3DaysOfSwift.com](https://www.3DaysOfSwift.com) | [3 Days Of Swift Bootcamp](https://www.3DaysOfSwift.com/bootcamp) | [Interview Prep](https://www.3DaysOfSwift.com/interview-prep)
//:
//: -------------------
//:
//: ## How to Integrate the Calculator class.
//:
//: This playground will demonstrate how to use the Calculator system in your app.
//:
//: The code below creates a new instance of the `Calculator` `class`. The instance is then programmed with the input of the equation as if a set of physical keys were pressed. The code demonstrates how to correctly use the Calculator API *(Application Programming Interface)*.
//:
//: For more details please look at the unit tests.
//:
//: -------------------
//:

// MARK: - 📦 Demo of 123 Calc (The business logic - No UI)

import Foundation // This framework includes the Decimal type
/*
 We create the calculator by passing in a provider function executed each time a new equation is created.

 The reason: In this project we use POP (Protocol Oriented Programming) to decoupling our solution from any concrete classes. For this to work, we must pass in a provider function executed each time a new equation is created.This is also known as "dependency injection" and "inversion of control".
 */
let calc = Model {
    EquationBuilder(equation: Equation())
}

// 0 + 1 = 1
calc.numberPressed(0)
calc.addPressed()
calc.numberPressed(1)
calc.equalsPressed()
calc.result

// 1 - 1 = 0
calc.numberPressed(1)
calc.minusPressed()
calc.numberPressed(1)
calc.equalsPressed()
calc.result

// 1 / 2 = 0.5
calc.numberPressed(1)
calc.dividePressed()
calc.numberPressed(2)
calc.equalsPressed()
calc.result

// 1 * 2 = 2
calc.numberPressed(1)
calc.multiplyPressed()
calc.numberPressed(2)
calc.equalsPressed()
calc.result
// << 🔵 Run Point

// MARK: - Addition To Result Of Previous Equation

/*
 We can apply a math operation to the result of an equation by pressing an operation button followed by a numeric value and the equals button.
 */
calc.clearPressed()

// 1 + 2 = 3
calc.numberPressed(1)
calc.addPressed()
calc.numberPressed(2)
calc.equalsPressed()
calc.result

// + 2 = 5
calc.addPressed()
calc.numberPressed(2)
calc.equalsPressed()
calc.result

// + 2 = 7
calc.addPressed()
calc.numberPressed(2)
calc.equalsPressed()
calc.result

// + 2 = 9
calc.addPressed()
calc.numberPressed(2)
calc.equalsPressed()
calc.result

// + 2 = 11
calc.addPressed()
calc.numberPressed(2)
calc.equalsPressed()
calc.result
// << 🔵 Run Point

// MARK: - Repeatedly Pressing The Equals Button

/*
 We can apply the same operation again by pressing the equals button again.

 This will take the last operation and apply it to the result of the current equation. i.e. if we have executed 1 + 2 = 3 and press the equals button once more + 2 will be appied again resulting in 3 + 2 = 5.
 */
calc.clearPressed()

// 1 + 2 = 3
calc.numberPressed(1)
calc.addPressed()
calc.numberPressed(2)
calc.equalsPressed()
calc.result

// + 2 = 5
calc.equalsPressed()
calc.result

// + 2 = 7
calc.equalsPressed()
calc.result

// + 2 = 9
calc.equalsPressed()
calc.result

// + 2 = 11
calc.equalsPressed()
calc.result
// << 🔵 Run Point
//:
//: -------------------
//: ## LCD Display Text
//: To mimick and replicate the behaviour of a physical calculator, the `Calculator` `class` implements a `textToDisplay` property.
//:
//: This property is updated upon each change to the equation and simply needs to be queried after each button press.
//:
//: Therefore if we wanted to use this `Calculator` within a UI *(User Interface)* we would do something like the following.
calc.clearPressed() // clear previous examples in this playground

// MARK: - Using The Calc With A UI (User Interface)

var textToDisplay = calc.textToDisplay // the LCD display of the calculator (if you imagine on a physical calculator)

func refreshDisplay() {
    textToDisplay = calc.textToDisplay
}

// numeric keyboard
func numberPressed(_ number: Int) {
    calc.numberPressed(number)
    refreshDisplay()
}

func zeroPressed() {
    numberPressed(0)
}

func onePressed() {
    numberPressed(1)
}

func twoPressed() {
    numberPressed(2)
}

func threePressed() {
    numberPressed(3)
}

func fourPressed() {
    numberPressed(4)
}

func fivePressed() {
    numberPressed(5)
}

func sixPressed() {
    numberPressed(6)
}

func sevenPressed() {
    numberPressed(7)
}

func eightPressed() {
    numberPressed(8)
}

func ninePressed() {
    numberPressed(9)
}

// decimal point
func decimalPressed() {
    calc.decimalPressed()
    refreshDisplay()
}

// math operations
func addPressed() {
    calc.addPressed()
    refreshDisplay()
}

func minusPressed() {
    calc.minusPressed()
    refreshDisplay()
}

func divisionPressed() {
    calc.dividePressed()
    refreshDisplay()
}

func multiplicationPressed() {
    calc.multiplyPressed()
    refreshDisplay()
}

// equals
func equalsPressed() {
    calc.equalsPressed()
    refreshDisplay()
}

// extra functions
func clearPressed() {
    calc.clearPressed()
    refreshDisplay()
}

func percentagePressed() {
    calc.percentagePressed()
    refreshDisplay()
}

func negatePressed() {
    calc.negatePressed()
    refreshDisplay()
}

// Let's try it!

// 9 * 4 = 36
ninePressed()
textToDisplay // displays 9
multiplicationPressed()
textToDisplay // still displays 9
fourPressed()
textToDisplay // displays 4
equalsPressed()
textToDisplay // displays result which is 36
// << 🔵 Run Point
//: The `textToDisplay` variable has been changing with each button press! 🎉
//:
//: This will remove any need for the UI *(User Interface)* to format the values received from the `Calculator` `class`. Instead the text simply needs to be refreshed.
//:
//: -------------------
//:
//: ## More Information
//: For more information take a look at our unit tests within the "123CalcTests" folder found within the project navigator pane.
//:
//: -------------------
//:
//:
//: ![3 Days Of Swift Logo](Footer.png) [Website](https://www.3DaysOfSwift.com) | [3 Days Of Swift Bootcamp](https://www.3DaysOfSwift.com/bootcamp) | [Interview Prep](https://www.3DaysOfSwift.com/interview-prep)
//:
//: © Copyright of [3DaysOfSwift.com](https://www.3DaysOfSwift.com). All rights reserved. Don't forget - come back when you've got an [interview](https://www.3DaysOfSwift.com/interview-prep)!
//:
//: Welcome to our community of [3DaysOfSwift.com](https://www.3DaysOfSwift.com) developers!
//:
//: 🧕🏻🙋🏽‍♂️👨🏿‍💼👩🏼‍💼👩🏻‍💻💁🏼‍♀️👨🏼‍💼🙋🏻‍♂️🙋🏻‍♀️👩🏼‍💻🙋🏿💁🏽‍♂️🙋🏽‍♀️🙋🏿‍♀️🧕🏾🙋🏼‍♂️
//:
