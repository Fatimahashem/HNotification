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
        case dinarMedium(size: CGFloat)
        case dinarBold(size: CGFloat)
        
        public var font: Font {
            switch self {
            case .dinarMedium(let size):
                FontLoader.shared.registerFontIfNeeded(fileName: "GEDinarOneMedium.ttf")
                return Font.custom("GE Dinar One Medium", size: size)
            case .dinarBold(let size):
                FontLoader.shared.registerFontIfNeeded(fileName: "alfont_com_GE-Dinar-One-Bold.otf")
                return Font.custom("GE Dinar One Bold", size: size)
            }
        }
    }
    
    final class FontLoader: @unchecked Sendable {
        static let shared = FontLoader()
        private var loadedFonts = Set<String>()
        private let queue = DispatchQueue(label: "FontLoaderQueue")
        
        private init() {}
        
        func registerFontIfNeeded(fileName: String) {
            queue.sync {
                guard !loadedFonts.contains(fileName) else { return }
                
                guard let url = Bundle.module.url(forResource: fileName, withExtension: nil) else {
                  
                    return
                }
                
                guard let dataProvider = CGDataProvider(url: url as CFURL),
                      let cgFont = CGFont(dataProvider) else {
                    return
                }
                
                var error: Unmanaged<CFError>?
                if CTFontManagerRegisterGraphicsFont(cgFont, &error) {
                    loadedFonts.insert(fileName)
                } else if let err = error?.takeUnretainedValue() {
                    _ = CFErrorCopyDescription(err) as String
                }
            }
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
