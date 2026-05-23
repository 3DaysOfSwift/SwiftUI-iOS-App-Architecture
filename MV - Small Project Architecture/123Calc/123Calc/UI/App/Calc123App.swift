//
//  Calc123App.swift
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
//   This file declares the main entry point of the app using the @main compiler attribute and the App protocol. This app struct is the declarative representation of the app object and therefore it is used to store the model. This is the type that brings both the View and the Model together - it is the glue between both horizontal layers of architecture. This type also declares the list of window groups that the app supports, which is only one for iPhone and perhaps several for macOS (or now iPadOS). The first compatible window group is the one displayed.
//  Architectural Layer: The user interface (UI) of the app.
// --------------------------------------------------

import SwiftUI

@main
struct Calc123App: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var themeManager: ThemeManager = ThemeManager(UserPreference(key: ThemeManager.keys.currentTheme))
    @StateObject var model = Calculator() // Note: We would not ever name this "model" in a commercial app. This name is to provide clear information that the model is the calculator itself. You could rename this to calculator.
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(model)
                .environmentObject(themeManager)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_: UIApplication, supportedInterfaceOrientationsFor _: UIWindow?) -> UIInterfaceOrientationMask {
        return .portrait
    }
}
