//
//  Calc123.swift
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
//   This file creates the main window of the app and provides the first view to display.
//   Architectural Layer: The user interface (UI) of the app.
//
// -------------------------------------------------------------------------------------------

import SwiftUI

// Note: EnvironmentValues is instantiated for each scene or new windowGroup
extension EnvironmentValues {
    @Entry var model: ModelAPI = Calculator() // each scene has its own Calculator (which is also the model in this smal app)
    @Entry var themeManager: ThemeManager = ThemeManager() // each scene has its own ThemeManager
}

@main
struct Calc123App: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
//    @State private(set) var model: ModelAPI = Calculator() // if this app was more complex, we might need to store one single instance of the model. Unlike producing a new model per scene, which this app currently does.

    var body: some Scene {
        WindowGroup {
            ContentView()
//                .environment(\.model, self.model)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_: UIApplication, supportedInterfaceOrientationsFor _: UIWindow?) -> UIInterfaceOrientationMask {
        return .portrait
    }
}
