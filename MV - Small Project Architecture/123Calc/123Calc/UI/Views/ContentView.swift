//
//  ContentView.swift
//  123Calc
//
//  Created by 3DaysOfSwift.com on 23/09/2025.
//
//  3DaysOfSwift.com                → All rights reserved
//  Website                         → https://www.3DaysOfSwift.com
//
//  We 🧡 Swift
//  Built for professional iOS developers.
//
//  🧕🏻🙋🏽‍♂️👨🏿‍💼👩🏼‍💼👩🏻‍💻💁🏼‍♀️👨🏼‍💼🙋🏻‍♂️🙋🏻‍♀️👩🏼‍💻🙋🏿💁🏽‍♂️🙋🏽‍♀️🙋🏿‍♀️🧕🏾🙋🏼‍♂️
// -------------------------------------------------------------------------------------------
//
// → What's This File?
//   This file outlines the instructions for displaying our data inside this view.
//   Architectural Layer: The user interface (UI) of the app.
//
// -------------------------------------------------------------------------------------------

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var themeManager: ThemeManager
    
    var body: some View {
        // Note: It's the ContentView that should declare the Navigation View
        NavigationView {
            CalculatorView()
        }
        .preferredColorScheme(themeManager.currentTheme.statusBarStyle == .dark ? .light : .dark)
    }
}

// MARK: - Previews - Development Feature (for when canvas is enabled)

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
