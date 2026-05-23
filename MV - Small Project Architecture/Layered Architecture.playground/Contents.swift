//: ![3DaysOfSwift.com Logo](3DaysOfSwift-Header.png) © 2026 [3DaysOfSwift.com](https://www.3DaysOfSwift.com)
//:
//: v1 | Swift v6.2.3+ | Xcode 26.2+
//:
//: -------------------
//:
//: ## 123 Calc App - Layered Architecture
//:
//: This professionally-written AppStore-quality app was structured (architected) to seperate the main "system" (also known as business-logic or the Model) and the UI. The UI (known as the presentation layer) sits as a horizontal layer on top of the main system, which is efficient if we want to change the user interface without affecting the underlying system.
//:
//: This means that the `CalculatorAPI` *(the interface to the system)* has been written as if buttons were going to be pressed to generate a basic math equation.
//:
//: ![123Calc screenshot](Calc123-UI.png)
//:
//: -------------------
//:
//: ## 🏛 123 Calc Architecture
//:
//: This calculator app is divided into 4 main parts:
//: * Visual UI layer - *the UI (User Interface)*
//: * Calculator - *the interface of the whole system performing actions triggered by input*
//: * EquationBuilder - *a manager building an equation from user input*
//: * Equation - *a raw math equation*
//:
//: -------------------
//:


/*

 123 Calc App Architecture
             _________________________________________
 Layer 4   → |            Visual UI layer            |  Tier 4 - UI    - SwiftUI Views
             -----------------------------------------
             ___________________↑_↓___________________
 Layer 3   → |               Calculator              |  Tier 3 - Model - Calculator & Interface
             -----------------------------------------
             ___________________↑_↓___________________
 Layer 2   → |             EquationBuilder           |  Tier 2 - Model - Building An Equation
             -----------------------------------------
             ___________________↑_↓___________________
 Layer 1   → |                Equation               |  Tier 1 - Model - Math Equation
             -----------------------------------------

  */


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
