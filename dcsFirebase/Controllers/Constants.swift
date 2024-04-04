//
//  Constants.swift
//  figmaSwift
//
//  Created by جبران on 01/01/2024.
//

import SwiftUI

class SafeAreaManager {
    static let shared = SafeAreaManager()
    var topInset: CGFloat = 59
    var bottomInset: CGFloat = 0
}

extension UIDevice {
    static var isIPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
    
    static var isIPhone: Bool {
        UIDevice.current.userInterfaceIdiom == .phone
    }
}

extension UIDevice {
    enum Fonts:String{
        case bold = "GESSTwoMedium-Medium"
        case light = "GESSTwoLight-Light"
    }
}
    
