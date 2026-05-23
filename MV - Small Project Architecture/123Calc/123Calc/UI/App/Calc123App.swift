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
//   This file creates the main window of the app and provides the first view to display.
//   Architectural Layer: The user interface (UI) of the app.
// --------------------------------------------------

import SwiftUI

@main
struct Calc123App: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var themeManager: ThemeManager = ThemeManager()
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
