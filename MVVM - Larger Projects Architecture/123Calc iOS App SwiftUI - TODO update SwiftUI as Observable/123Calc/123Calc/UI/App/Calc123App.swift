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


extension EnvironmentValues {
    @Entry var model: ModelAPI = AppBrain()
    @Entry var themeManager: ReactiveThemeManager = ReactiveThemeManager()
}

@main
struct Calc123App: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @State private(set) var model: ModelAPI = AppBrain()
    @State private var themeManager = ReactiveThemeManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.model, self.model)
                .environment(\.themeManager, self.themeManager)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_: UIApplication, supportedInterfaceOrientationsFor _: UIWindow?) -> UIInterfaceOrientationMask {
        return .portrait
    }
}
