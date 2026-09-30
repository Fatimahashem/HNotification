import SwiftUI

public struct PromotionOverlay: View {
    @ObservedObject private var viewModel: PromotionViewModel
    private let locale: Locale
    private let onSelect: (Promotion) -> Void

    public init(
        viewModel: PromotionViewModel,
        locale: Locale = .current,
        onSelect: @escaping (Promotion) -> Void = { _ in }
    ) {
        self.viewModel = viewModel
        self.locale = locale
        self.onSelect = onSelect
    }

    public var body: some View {
        if let promotion = viewModel.promotion {
            ZStack {
                Theme.Colors.scrim.opacity(0.48)
                    .ignoresSafeArea()
                    .onTapGesture(perform: viewModel.dismiss)

                VStack(spacing: 16) {
                    ModalCard {
                        VStack(spacing: 8) {
                            FeatureImage(promotion.artwork.rawValue)
                                .frame(height: 200)
                                .padding(16)
                            Text(promotion.title)
                                .font(Theme.AppFont.dinarBold(size: 35).font)
                                .foregroundStyle(Theme.Colors.promotionalAccent)
                            Text(promotion.message)
                                .font(Theme.AppFont.dinarMedium(size: 16).font)
                        }
                        .onTapGesture { onSelect(promotion) }
                    }
                    ModalCloseButton(locale: locale, action: viewModel.dismiss)
                }
                .padding(16)
                .overlay(alignment: .topLeading) {
                    if let timer = viewModel.formattedRemainingTime {
                        CountdownBadge(value: timer, locale: locale)
                            .offset(x: 8, y: 0)
                    }
                }
            }
            .transition(.opacity.combined(with: .scale(scale: 0.96)))
            .featureScreenStyle()
            .environment(\.locale, locale)
        }
    }
}
#Preview("Promotion") {
    ZStack {
        Color.gray

        PromotionOverlay(
            viewModel: PromotionViewModel(
                promotion: .extraCredit(
                    deadline: Date().addingTimeInterval(12_000),
                    locale: Locale(identifier: "ar")
                )
            ),
            locale: Locale(identifier: "ar")
        )
    }
}
