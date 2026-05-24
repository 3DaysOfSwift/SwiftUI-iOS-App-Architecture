![3 Days of Swift](readme-images/3DaysOfSwift-Header.png) 
© 2026 [3DaysOfSwift.com](https://www.3DaysOfSwift.com). All rights reserved.


## This Repository

This repository contains two SwiftUI Xcode projects alongside two supporting Xcode playgrounds designed to help developers understand the architectural patterns commonly discussed in iOS interviews — MV and MVVM. MVC can be found in another UIKit-based repo. 

These projects and playgrounds focus on separating application logic from the user interface, helping developers better understand how Swift applications can be structured for clarity and maintainability.


## 2x SwiftUI Xcode Projects (MV & MVVM)

Included within this repository are two SwiftUI Xcode projects demonstrating both MV and MVVM architecture patterns.

The MV project demonstrates a lightweight architecture suitable for smaller applications and simple prototypes, while the MVVM project introduces a more scalable structure commonly used in larger commercial applications.

Explore both projects to compare how models, business logic, and views can be organised to improve readability, stability, and long-term maintainability.


## What do you Mean by Model-View (MV)?
For the purposes of this project, we describe this as Model–View (MV), because the SwiftUI views communicate directly with an observable model supplied through the environment. 
[Resource 1](https://developer.apple.com/documentation/SwiftUI/Managing-model-data-in-your-app) [Resource 2](https://developer.apple.com/documentation/swiftui/environmentobject)

In this case each View communicates directly to this Model (passed into the environment) - hence Model-View. 

SwiftUI often removes the need for a separate controller/view-model layer in smaller apps. But the reality of working in the tech industry building commercial apps means that the Apple supplied demo-apps are just not always enough to support the larger needs of a bigger project.


## Can I Use MVVM in My SwiftUI Apps?
Yes, however you may run into some issues trying to store and access the Model from each ViewModel. In MVVM each SwiftUI View will communicate with its own unique ViewModel object, but never the Model directly. This is why it’s called a “view model” because it is the only Model that the View communicates with - its own unique custom Model that acts as the “middle man” between the View and the main Model.

As SwiftUI favours direct communication between the Model and the View, it is problematic to setup each ViewModel and developers usually result in passing in ViewModels through dependency injection into the initialisers of each SwiftUI View - don’t do this! This harms the internal workings of SwiftUI.

Instead, the easiest implementation (and simplest) is to use the singleton design pattern on the Model, so that each `ViewModel` can link to it once inside its initialiser when created by SwiftUI.

A brief example is below and this is what exists in the MVVM Xcode project of this repo.

```Swift
// Note: We can declare a singleton within the MyiOSApp.swift file, which helps to remove the concept of a singleton from the actual implementation of the Model. It removes the idea of a singleton from unit tests and is a nice little idea perhaps.
extension Model {
    static let shared: Model = {
        let customParameters = SomeCustomParameters(key: AppConstants.apiKeyForSomething)
        let model = Model(customSetup: customParameters)
        return model
    }()
}

@main
struct MyiOSApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
```

```Swift
struct ContentView: View {
    var body: some View {
        NavigationView {
            MySwiftUIView() // Note: We don't ever use dependency injection here! This is "declarative" code not "imperative". 
          // Tip: this code says "this is what this view looks like". But it does not say, create this code! This is why we must change our thoughts on loosely coupling our code here and using dependency injection. 
        }
    }
}
```

```Swift
struct MySwiftUIView: View {   
    @StateObject private var viewModel = MySwiftUIView_ViewModel() // no Dependency Injection. Just clean simple instantiation which SwiftUI handles for us
  var body: some View {
	...
  }
}
```

```Swift
final class MySwiftUIView_ViewModel: ObservableObject {
    private let model: Model
    init() {
        self.model = Model.shared 
    }
}
```

## The Model Isolated in a Playground

The shared application model used throughout both Xcode projects has been isolated into this dedicated Xcode playground.

This playground focuses entirely on the model, making it easier to understand how application data and business logic can exist independently from the user interface.


------------------------

Download this Xcode project at [3DaysOfSwift.com](https://www.3DaysOfSwift.com).

------------------------


## Official Swift Documentation
Apple created [The Swift Programming Language (TSPL)](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/thebasics) book to discuss and describe the following language features.

1. [The Basics](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/thebasics)
2. [Basic Operators](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/basicoperators)
3. [Strings and Characters](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/stringsandcharacters)
4. [Collection Types](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/collectiontypes)
5. [Control Flow](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/controlflow)
6. [Functions](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/functions)
7. [Closures](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/closures)
8. [Enumerations](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/enumerations)
9. [Structures and Classes](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/classesandstructures)
10. [Properties](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/properties)
11. [Methods](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/methods)
12. [Subscripts](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/subscripts)
13. [Inheritance](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/inheritance)
14. [Initialization](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/initialization)
15. [Deinitialization](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/deinitialization)
16. [Optional Chaining](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/optionalchaining)
17. [Error Handling](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/errorhandling)
18. [Concurrency](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/concurrency)
19. [Macros](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/macros)
20. [Type Casting](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/typecasting)
21. [Nested Types](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/nestedtypes)
22. [Extensions](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/extensions)
23. [Protocols](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/protocols)
24. [Generics](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/generics)
25. [Opaque Types](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/opaquetypes)
26. [Automatic Reference Counting](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/automaticreferencecounting)
27. [Memory Safety](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/memorysafety)
28. [Access Control](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/accesscontrol)
29. [Advanced Operators](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/advancedoperators)

Read our Xcode playground conversion only at [3DaysOfSwift.com](https://www.3DaysOfSwift.com)

--------------------------


![3 Days of Swift](readme-images/3DaysOfSwift-Header.png)

[Website](https://www.3DaysOfSwift.com) | [Subreddit Community](https://www.reddit.com/r/3DaysOfSwift)

© 2026 [3DaysOfSwift.com](https://www.3DaysOfSwift.com). All rights reserved.

Built for professional iOS developers.

👩🏿‍💻🧑🏻‍💻🙋🏿‍♀️🧑🏼‍💻👩🏼‍💼👩🏽‍💻🧑🏿‍💻💁🏼‍♀️👩🏼‍💻👨🏼‍💻👨🏽‍💻🙋🏽‍♂️👩🏻‍💻🧑🏾‍💻👩🏻‍💻👩🏾‍💻👨🏼‍💻🙋🏻‍♂️👨🏿‍💻🙋🏼‍♂️