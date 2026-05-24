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

/**
NOTE: In MVVM the View only knows about the ViewModels and not the Model iteself.
 These ViewModels (one for each view) will need to access the single instance of the model.
 In which case, SwiftUI doesn't support this behaviour and trying to force it will create problems.
 Considering the @StateObject generates a shared single instance anyway we can use a singleton
 and remove any of the headaches that SwiftUI and @StateObject bring.
 
 Please remember that academically we might not want to use a singleton because it bypasses architecture and
 is globally accessible. However, in reality, we need to separate the View and its ViewModels from the Model.
 A singleton will support this and is much cleaner and less error prone that any current offering from SwiftUI.
*/
extension Calculator {
    static let shared: Calculator = {
        let userPreference = UserPreference<Equation>(key: Calculator.keys.previousEquation)
        let model = Calculator(userPreference)
        let _ = model.restoreFromLastSession()
        return model
    }()
}

@main
struct Calc123App: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var themeManager: ThemeManager = ThemeManager(UserPreference(key: ThemeManager.keys.currentTheme))
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(themeManager)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_: UIApplication, supportedInterfaceOrientationsFor _: UIWindow?) -> UIInterfaceOrientationMask {
        return .portrait
    }
}
