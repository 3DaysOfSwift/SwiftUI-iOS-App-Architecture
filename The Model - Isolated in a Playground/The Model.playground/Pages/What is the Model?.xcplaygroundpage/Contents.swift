//: ![3DaysOfSwift.com Logo](3DaysOfSwift-Header.png) © 2026 [3DaysOfSwift.com](https://www.3DaysOfSwift.com)
//:
//: Version 1.0 | Swift 6.2.3+ | Xcode 26.2+
//:
//: -------------------
//:
//: ## What is the Model?
//:
//: In software development, “the model” refers to the part of an application responsible for managing and representing the application’s data and business logic. i.e. the system itself!
//:
//: A great way to "think" of this is to imagine a [Terminal](https://support.apple.com/en-vn/guide/terminal/welcome/mac) program that is 100% functional but is only controllable by using a text entry prompt window.
//:
//: ![Terminal Program](Terminal-Screenshot.png)
/*:
 */
//: The Swift code that powers this calculator "program" (aka the model) might look like this...
//:
//: -------------------
//:


// final informs the Swift compiler this class cannot be inheritted from
final class Calculator {

    func add(_ lhs: Int, _ rhs: Int) -> Int {
        lhs + rhs
    }

    func subtract(_ lhs: Int, _ rhs: Int) -> Int {
        lhs - rhs
    }

    func multiply(_ lhs: Int, _ rhs: Int) -> Int {
        lhs * rhs
    }

    func divide(_ lhs: Int, _ rhs: Int) -> Int {
        lhs / rhs
    }
}



//:
//: -------------------
//:
//: ## That's it!
//:
//: That is all the explanation needed.
//:
//: The "model" (Calculator) is responsible for the program’s behaviour and logic, while another part of the application (such as a SwiftUI view) can be responsible for displaying the results on screen.
//:
//:
//: -------------------
//:
/*:
 */
//: * callout(💡 Some Basic Rules):
//:     The model doesn't "care" about how it's displayed. In fact, it shouldn't even be aware of *how* it's displayed.
//:
//:     The model's only purpose is to complete the tasks given to it, which might include producing a result of some kind. But how that result is displayed and represented to the user is the role of a different entity - the view. The view can be thought of as a wrapper for the model or even more commonly, a second horizontal-layer placed on top of the model.
//:
//: -------------------
//:
//: ## Interface
//:
//: Now that a model has been written and created we need an "interface" to communicate with it, initiate commands and display resutls.
//:
//: This playground already provides us with an interface within this top-level code.
//:
//: 👉 Let's use the code area below to use our Calculator model and produce a displayed result within both the Results View and the Console Window.
//:
//: -------------------
//:


// instantiate a new instance of the model
let calculator = Calculator()

// trigger actions and display the results to the user
print(calculator.add(10, 5))
print(calculator.subtract(10, 5))
print(calculator.multiply(10, 5))
print(calculator.divide(10, 5)) // 👈 Execute here


//:
//: -------------------
//:
//: [Next Playground  ▶](@next)
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
