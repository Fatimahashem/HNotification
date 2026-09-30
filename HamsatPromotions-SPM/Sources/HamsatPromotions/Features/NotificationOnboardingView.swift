import SwiftUI

public struct NotificationOnboardingView: View {
    private let onEnable: () -> Void
    private let onLater: () -> Void
    private let locale: Locale

    public init(
        locale: Locale = .current,
        onEnable: @escaping () -> Void,
        onLater: @escaping () -> Void = {}
    ) {
        self.locale = locale
        self.onEnable = onEnable
        self.onLater = onLater
    }

    public var body: some View {
        ZStack {
            FeatureImage("OnboardingBackground", contentMode: .fill)
                .ignoresSafeArea()

            VStack(spacing: 20) {
                Spacer(minLength: 10)
                FeatureImage("NotificationPhone")
                    .frame(maxWidth: 180, maxHeight: 300)
                
                VStack(spacing: 20) {
                    Text(
                        locale.localizedResource(
                            "onboarding.notifications.title",
                            defaultValue: "Enable Notifications"
                        )
                    )
                        .font(Theme.AppFont.hero)
                        .foregroundStyle(Theme.Colors.primaryAccent)
                    Text(
                        locale.localizedResource(
                            "onboarding.notifications.body",
                            defaultValue: "Turn on your notifications so you can stay up to date at all times"
                        )
                    )
                        .font(Theme.AppFont.body)
                }
                .padding(.bottom, 10)

                Button(action: onEnable) {
                    Text(
                        locale.localizedResource(
                            "onboarding.notifications.enable",
                            defaultValue: "Enable Notifications"
                        )
                    )
                }
                    .primaryButtonStyle()
                    .padding(.horizontal, 10)

                Button(action: onLater) {
                    Text(
                        locale.localizedResource(
                            "common.later",
                            defaultValue: "Later"
                        )
                    )
                }
                    .font(Theme.AppFont.button)
                    .foregroundStyle(Theme.Colors.secondaryText)
                    .padding(32)
                Spacer(minLength: 24)
            }
        }
        .featureScreenStyle()
        .environment(\.locale, locale)
    }
}
#Preview("Onboarding · Arabic") {
    NotificationOnboardingView(
        locale: Locale(identifier: "ar"),
        onEnable: {},
        onLater: {}
    )
}
