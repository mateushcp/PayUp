//
//  Colors.swift
//  PayUp
//
//  Created by Mateus Henrique Coelho de Paulo on 21/04/25.
//

import Foundation
import UIKit

enum Colors {
    static let backgroundPrimary = UIColor(hex: "#000000")
    static let backgroundSecondary = UIColor(hex: "#1A1A1A")
    static let backgroundTertiary = UIColor(hex: "#2D2D2D")

    static let accentBrand = UIColor(hex: "#57F2BE")
    static let accentBrandDark = UIColor(hex: "#00C189")
    static let accentGreen = UIColor(hex: "#9BF7B7")
    static let accentOrange = UIColor(hex: "#FFA94D")
    static let accentRed = UIColor(hex: "#FF5E5E")

    static let textHeading = UIColor(hex: "#FFFFFF")
    static let textSpan = UIColor(hex: "#B2B2B2")
    static let textParagraph = UIColor(hex: "#C5C5C5")
    static let textInvert = UIColor(hex: "#001C12")
    static let textPlaceholder = UIColor(hex: "#777777")
    static let textLabel = UIColor(hex: "#EDEDED")

    static let borderPrimary = UIColor(hex: "#2D2D2D")
}

extension UIColor {
    convenience init(hex: String) {
        var hexFormatted: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        hexFormatted = hexFormatted.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgb)

        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
