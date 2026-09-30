import SwiftUI

public struct CountdownBadge: View {
    public let value: String
    public let locale: Locale

    public init(value: String, locale: Locale = .current) {
        self.value = value
        self.locale = locale
    }

    public var body: some View {
        Text(
            locale.localizedResource(
                "promotion.countdown",
                defaultValue: "Time left: \(value)"
            )
        )
        .font(Theme.AppFont.dinarMedium(size: 15).font)
            .foregroundStyle(Theme.Colors.surface)
            .padding(.horizontal, 16)
            .frame(height: 34)
            .background(Theme.Colors.promotionalAccent)
            .clipShape(RoundedRectangle(cornerRadius: Theme.Radius.card, style: .continuous))
            .accessibilityLabel(
                locale.localizedResource(
                    "promotion.countdown.accessibility",
                    defaultValue: "Time remaining: \(value)"
                )
            )
            .environment(\.locale, locale)
    }
}
