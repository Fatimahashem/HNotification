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
            locale.localizedString(
                "promotion.countdown",
                defaultValue: "Time left: \(value)"
            )
        )
        .font(Theme.AppFont.dinarMedium(size: 15).font)
        .foregroundStyle(Theme.Colors.surface)
        .padding(.horizontal, 16)
        .frame(height: 34)
        .background {
            CountdownBadgeShape(cornerRadius: Theme.Radius.card)
                .fill(Theme.Colors.promotionalAccent)
        }
        .accessibilityLabel(
            locale.localizedString(
                "promotion.countdown.accessibility",
                defaultValue: "Time remaining: \(value)"
            )
        )
        .environment(\.locale, locale)
    }
}

private struct CountdownBadgeShape: Shape {
    let cornerRadius: CGFloat

    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + cornerRadius))
        path.addQuadCurve(
            to: CGPoint(x: rect.minX + cornerRadius, y: rect.minY),
            control: CGPoint(x: rect.minX, y: rect.minY)
        )
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - cornerRadius))
        path.addQuadCurve(
            to: CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY),
            control: CGPoint(x: rect.maxX, y: rect.maxY)
        )
        path.closeSubpath()
        return path
    }
}
