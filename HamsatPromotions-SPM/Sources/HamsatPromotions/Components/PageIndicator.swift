import SwiftUI

public struct PageIndicator: View {
    public let count: Int
    public let selectedIndex: Int
    public let locale: Locale

    public init(
        count: Int,
        selectedIndex: Int,
        locale: Locale = .current
    ) {
        self.count = count
        self.selectedIndex = selectedIndex
        self.locale = locale
    }

    public var body: some View {
        HStack(spacing: 12) {
            ForEach(0..<count, id: \.self) { index in
                Circle()
                    .fill(index == selectedIndex ? Theme.Colors.promotionalAccent : Theme.Colors.secondaryText.opacity(0.25))
                    .frame(width: 10, height: 10)
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(
            locale.localizedString(
                "tutorial.page.accessibility",
                defaultValue: "Page \(selectedIndex + 1) of \(count)"
            )
        )
        .environment(\.locale, locale)
    }
}
