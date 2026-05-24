//: ![3DaysOfSwift.com Logo](3DaysOfSwift-Header.png) © 2026 [3DaysOfSwift.com](https://www.3DaysOfSwift.com)
//:
//: Version 1.0 | Swift 6.2.3+ | Xcode 26.2+
//:
//: -------------------
//:
//: ## The View
//:
//: We have placed the model inside its own Model.swift file and placed it within the Sources folder for this playground page.
//:
//: This is a great way to properly visualise the true divide between the model and the view, because they are now physically divided and this restriction will prevent developers from confusing which is which.
//:
//: ![Playground Sources Folder](SourcesFolder.png)
/*:
 */
//: 👉 Consider this playground to be the View. We have full access to the model, but we cannot edit the code. Use the model to execute your own equation of `100.001 * 2` and print the result to the console.
//:
//: -------------------
//:


// instantiate a new instance of the iOS Calculator model
let calculator = Calculator()

// in this model, the calculator stores and handles the user input
// as if the user would press buttons on a 0-9 numeric keypad.
// The model keeps track of the values entered
// and provides a result when we request the equation to be executed
// Note: This model can be easily plugged-in to an iOS interface,
// but also lacks the ability to be extended in functionality.
// It does make a very good learning resource though!
calculator.enterOne()
calculator.enterZero()
calculator.enterDecimalState()
calculator.enterOne()
calculator.add()
calculator.enterZero()
calculator.enterDecimalState()
calculator.enterNine()
print("10.1 + 0.9 = \(calculator.execute())") // 👈 Execute here

calculator.clear()

//
calculator.enterSix()
calculator.add()
calculator.enterFour()
print("6 + 4 = \(calculator.execute())") // 👈 Execute here


//:
//: -------------------
//:
//: [◀  Previous Playground](@previous)  |  [Next Playground  ▶](@next)
//:
//: -------------------
//:
//: ![3DaysOfSwift.com Logo](3DaysOfSwift-Header.png) © 2026 [3DaysOfSwift.com](https://www.3DaysOfSwift.com). All rights reserved.
//:
//: [Website](https://www.3DaysOfSwift.com) | [Subreddit Community](https://www.Reddit.com/r/3DaysOfSwift)
//:
//: Built for professional iOS developers.
//:
//: 👩🏿‍💻🧑🏻‍💻🙋🏿‍♀️🧑🏼‍💻👩🏼‍💼👩🏽‍💻🧑🏿‍💻💁🏼‍♀️👩🏼‍💻👨🏼‍💻👨🏽‍💻🙋🏽‍♂️👩🏻‍💻🧑🏾‍💻👩🏻‍💻👩🏾‍💻👨🏼‍💻🙋🏻‍♂️👨🏿‍💻🙋🏼‍♂️
//:
