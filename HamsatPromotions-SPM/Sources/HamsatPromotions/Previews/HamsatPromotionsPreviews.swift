#if DEBUG
import SwiftUI

#Preview("Onboarding · Arabic") {
    NotificationOnboardingView(
        locale: Locale(identifier: "ar"),
        onEnable: {},
        onLater: {}
    )
}

#Preview("Onboarding · English") {
    NotificationOnboardingView(
        locale: Locale(identifier: "en"),
        onEnable: {},
        onLater: {}
    )
}

#Preview("Extra Credit Promotion · Arabic") {
    PromotionCanvas(
        promotion: .extraCredit(
            deadline: Date().addingTimeInterval(11_522),
            locale: Locale(identifier: "ar")
        ),
        locale: Locale(identifier: "ar")
    )
}

#Preview("Limited Offer · English") {
    PromotionCanvas(
        promotion: .fiveDollarOffer(
            deadline: Date().addingTimeInterval(11_522),
            locale: Locale(identifier: "en")
        ),
        locale: Locale(identifier: "en")
    )
}

#Preview("Tutorial · Arabic") {
    let locale = Locale(identifier: "ar")
    TutorialOverlay(
        viewModel: TutorialViewModel(locale: locale),
        locale: locale
    )
}

@MainActor
private struct PromotionCanvas: View {
    @StateObject private var viewModel: PromotionViewModel
    private let locale: Locale

    init(promotion: Promotion, locale: Locale) {
        _viewModel = StateObject(wrappedValue: PromotionViewModel(promotion: promotion))
        self.locale = locale
    }

    var body: some View {
        ZStack {
            Color.gray.opacity(0.15).ignoresSafeArea()
            PromotionOverlay(viewModel: viewModel, locale: locale)
        }
    }
}
#endif
