//
//  ColorExtension.swift
//  LiquidQuiz
//
//  Created by Roman Tverdokhleb on 11/06/2025.
//

import SwiftUI

extension Color {
    enum LabelColors {
        static let primary = Color("LabelPrimary")
        static let secondary = Color("LabelSecondary")
        static let disable = Color("LabelDisable")
        static let blue = Color("LabelBlue")
        static let purple = Color("LabelPurple")
        static let white = Color("LabelWhite")
    }
    
    enum BackgroundColors {
        static let main = Color("BackMain")
        static let primary = Color("BackPrimary")
    }
    
    enum SupportColors {
        static let orange = Color("SupportOrange")
        static let red = Color("SupportRed")
        static let lightOrange = Color("SupportLightOrange")
        static let purple = Color("SupportPurple")
    }
    
    enum Gradient {
        static let blue = Color("GradientBlue")
        static let lavender = Color("GradientLavender")
        static let mint = Color("GradientMint")
        static let peach = Color("GradientPeach")
        static let yellow = Color("GradientYellow")
    }
}
