import SwiftUI

public struct ModalCloseButton: View {
    private let locale: Locale
    private let action: () -> Void

    public init(locale: Locale = .current, action: @escaping () -> Void) {
        self.locale = locale
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            Image(systemName: "xmark")
                .font(.title2.bold())
                .foregroundStyle(Theme.Colors.secondaryText)
                .frame(width: 44, height: 44)
                .background(Theme.Colors.surface)
                .clipShape(Circle())
        }
        .accessibilityLabel(
            locale.localizedString(
                "common.close",
                defaultValue: "Close"
            )
        )
        .environment(\.locale, locale)
    }
}
