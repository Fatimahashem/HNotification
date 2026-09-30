import SwiftUI

public struct FeatureScreenModifier: ViewModifier {
    public init() {}

    public func body(content: Content) -> some View {
        content
            .foregroundStyle(Theme.Colors.primaryText)
            .multilineTextAlignment(.center)
    }
}

public struct PrimaryButtonModifier: ViewModifier {
    private let isEnabled: Bool

    public init(isEnabled: Bool = true) {
        self.isEnabled = isEnabled
    }

    public func body(content: Content) -> some View {
        content
            .font(Theme.AppFont.dinarMedium(size: 22).font)
            .foregroundStyle(Theme.Colors.surface)
            .frame(maxWidth: .infinity, minHeight: 54)
            .background(Theme.Colors.promotionalAccent.opacity(isEnabled ? 1 : 0.45))
            .clipShape(RoundedRectangle(cornerRadius: Theme.Radius.button, style: .continuous))
    }
}

public extension View {
    func featureScreenStyle() -> some View { modifier(FeatureScreenModifier()) }
    func primaryButtonStyle(isEnabled: Bool = true) -> some View {
        modifier(PrimaryButtonModifier(isEnabled: isEnabled))
    }
}
