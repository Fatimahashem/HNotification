import SwiftUI

public struct TutorialOverlay: View {
    @ObservedObject private var viewModel: TutorialViewModel
    private let locale: Locale
    private let onDismiss: () -> Void

    public init(
        viewModel: TutorialViewModel,
        locale: Locale = .current,
        onDismiss: @escaping () -> Void = {}
    ) {
        self.viewModel = viewModel
        self.locale = locale
        self.onDismiss = onDismiss
    }

    public var body: some View {
        ZStack {
            Theme.Colors.scrim.opacity(0.48).ignoresSafeArea()

            VStack(spacing: 16) {
                ModalCard {
                    tutorialPages
                    #if os(iOS)
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    #endif
                    .frame(height: 390)

                    PageIndicator(
                        count: viewModel.pages.count,
                        selectedIndex: viewModel.selectedIndex,
                        locale: locale
                    )
                        .padding(.top, 16)
                }

                ModalCloseButton(locale: locale, action: onDismiss)
            }
            .padding(16)
        }
        .featureScreenStyle()
        .environment(\.locale, locale)
    }

    private var tutorialPages: some View {
        TabView(selection: $viewModel.selectedIndex) {
            ForEach(Array(viewModel.pages.enumerated()), id: \.element.id) { index, page in
                VStack(spacing: 16) {
                    FeatureImage(page.artwork.rawValue)
                        .frame(height: 220)
                    Text(page.title)
                        .font(Theme.AppFont.dinarBold(size: 35).font)
                        .foregroundStyle(Theme.Colors.promotionalAccent)
                    Text(page.message)
                        .font(Theme.AppFont.dinarMedium(size: 16).font)
                        .frame(minHeight: 48)
                }
                .tag(index)
            }
        }
    }
}
