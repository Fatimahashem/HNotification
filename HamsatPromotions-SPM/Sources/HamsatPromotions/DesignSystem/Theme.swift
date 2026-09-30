import SwiftUI
#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

/// Semantic design tokens shared by every view in the feature.
public enum Theme {
    public enum Colors {
        public static let surface = Color("PureWhite", bundle: .module)
        public static let primaryAccent = Color("PrimaryAccentBlue", bundle: .module)
        public static let primaryText = Color("DarkSlate", bundle: .module)
        public static let promotionalAccent = Color("AccentPink", bundle: .module)
        public static let secondaryText = Color("MutedGreyPurple", bundle: .module)
        public static let scrim = Color("PureBlack", bundle: .module)
    }

    public enum Radius {
        public static let button: CGFloat = 10
        public static let card: CGFloat = 18
        public static let modal: CGFloat = 22
    }

    public enum AppFont {
        public static let familyName = "GE Dinar One"

        public static let hero = font(size: 34, relativeTo: .largeTitle, weight: .bold)
        public static let modalTitle = font(size: 31, relativeTo: .title, weight: .bold)
        public static let body = font(size: 17, relativeTo: .body, weight: .medium)
        public static let button = font(size: 20, relativeTo: .title3, weight: .semibold)
        public static let timer = font(size: 16, relativeTo: .callout, weight: .bold)

        public static func font(
            size: CGFloat,
            relativeTo textStyle: Font.TextStyle,
            weight: Font.Weight = .regular
        ) -> Font {
            guard isFontAvailable else {
                return .system(size: size, weight: weight)
            }
            return .custom(familyName, size: size, relativeTo: textStyle).weight(weight)
        }

        private static var isFontAvailable: Bool {
            #if canImport(UIKit)
            UIFont(name: familyName, size: 17) != nil
            #elseif canImport(AppKit)
            NSFont(name: familyName, size: 17) != nil
            #else
            false
            #endif
        }
    }
}

public extension Color {
    /// Creates a color from RGB/RGBA hex without leaking parsing into feature views.
    init(hex: String, opacity: Double = 1) {
        let cleaned = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var value: UInt64 = 0
        Scanner(string: cleaned).scanHexInt64(&value)
        let channels: (UInt64, UInt64, UInt64, UInt64)
        switch cleaned.count {
        case 3:
            channels = (
                ((value >> 8) & 0xF) * 17,
                ((value >> 4) & 0xF) * 17,
                (value & 0xF) * 17,
                255
            )
        case 8:
            channels = (value >> 24, (value >> 16) & 0xFF, (value >> 8) & 0xFF, value & 0xFF)
        default:
            channels = (value >> 16, (value >> 8) & 0xFF, value & 0xFF, 255)
        }
        self.init(
            .sRGB,
            red: Double(channels.0 & 0xFF) / 255,
            green: Double(channels.1) / 255,
            blue: Double(channels.2) / 255,
            opacity: opacity * Double(channels.3) / 255
        )
    }
}
