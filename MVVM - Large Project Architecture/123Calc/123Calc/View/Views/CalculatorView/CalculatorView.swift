//
//  CalculatorView.swift
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
//   This file outlines the instructions for displaying our data inside this view.
//   Architectural Layer: The user interface (UI) of the app.
// --------------------------------------------------

import SwiftUI

struct CalculatorView: View {
    
    // MARK: Datasource Properties
    
    @StateObject private var viewModel = CalculatorView_ViewModel()
    @EnvironmentObject var themeManager: ThemeManager
    
    private let buttonSize = CGSize(width: 78, height: 78)
    
    // MARK: Main View Builder

    var body: some View {
        VStack {
            Spacer(minLength: 20)
            Text(viewModel.textToDisplay)
                .lineLimit(1)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding()
                .font(.system(size: 90))
                .minimumScaleFactor(0.5)
                .foregroundColor(Color(hex: themeManager.currentTheme.display))
                .onTapGesture(count: 2) {
                    rotateToNextTheme()
                }
            
            HStack {
                Group {
                    extraFeatureButton("AC") {
                        viewModel.clearPressed()
                    }
                    extraFeatureButton("⁺∕₋") {
                        viewModel.negatePressed()
                    }
                    extraFeatureButton("%") {
                        viewModel.percentagePressed()
                    }
                    operatorButton("÷") {
                        viewModel.dividePressed()
                    }
                }
            }
            
            HStack {
                Group {
                    pinPadButton("7") {
                        viewModel.numberPressed(7)
                    }
                    pinPadButton("8") {
                        viewModel.numberPressed(8)
                    }
                    pinPadButton("9") {
                        viewModel.numberPressed(9)
                    }
                    operatorButton("X") {
                        viewModel.multiplyPressed()
                    }
                }
            }
            
            HStack {
                Group {
                    pinPadButton("4") {
                        viewModel.numberPressed(4)
                    }
                    pinPadButton("5") {
                        viewModel.numberPressed(5)
                    }
                    pinPadButton("6") {
                        viewModel.numberPressed(6)
                    }
                    operatorButton("-") {
                        viewModel.minusPressed()
                    }
                }
            }
            
            HStack {
                Group {
                    pinPadButton("1") {
                        viewModel.numberPressed(1)
                    }
                    pinPadButton("2") {
                        viewModel.numberPressed(2)
                    }
                    pinPadButton("3") {
                        viewModel.numberPressed(3)
                    }
                    operatorButton("+") {
                        viewModel.addPressed()
                    }
                }
            }
            
            HStack {
                Group {
                    pinPadButton("0", widthModifier: 2.1) {
                        viewModel.numberPressed(0)
                    }
                    pinPadButton(".") {
                        viewModel.decimalPressed()
                    }
                    operatorButton("=") {
                        viewModel.equalsPressed()
                    }
                }
            }
            
            Spacer(minLength: 20)
        }
        .background(Color(hex: themeManager.currentTheme.background))
    }

    // MARK: Button Builders

    @ViewBuilder func pinPadButton(_ label: String, widthModifier: CGFloat = 1, _ action: @escaping () -> Void) -> some View {
        Button(action: {
            action()
        }, label: {
            Text(label)
                .font(.largeTitle)
                .frame(width: buttonSize.width * widthModifier, height: buttonSize.height)
                .background(Color(hex: themeManager.currentTheme.pinPad))
                .foregroundColor(Color(hex: themeManager.currentTheme.pinPadTitle))
                .cornerRadius(10)
        })
    }

    @ViewBuilder func operatorButton(_ label: String, _ action: @escaping () -> Void) -> some View {
        Button(action: {
            action()
        }, label: {
            Text(label)
                .font(.largeTitle)
                .frame(width: buttonSize.width, height: buttonSize.height)
                .background(Color(hex: themeManager.currentTheme.operatorNormal))
                .foregroundColor(Color(hex: themeManager.currentTheme.operatorTitle))
                .cornerRadius(10)
        })
    }

    @ViewBuilder func extraFeatureButton(_ label: String, _ action: @escaping () -> Void) -> some View {
        Button(action: {
            action()
        }, label: {
            Text(label)
                .font(.largeTitle)
                .frame(width: buttonSize.width, height: buttonSize.height)
                .background(Color(hex: themeManager.currentTheme.extraFunctions))
                .foregroundColor(Color(hex: themeManager.currentTheme.extraFunctionsTitle))
                .cornerRadius(10)
        })
    }

    // MARK: Changing Themes

    // TODO: Provide a button to rotate to the next colour theme
    private func rotateToNextTheme() {
        themeManager.moveToNextTheme()
    }
}

// MARK: - Previews - Development Feature (for when canvas is enabled)

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
