# HamsatPromotions

An iOS 16+ SwiftUI package containing notification onboarding, timed promotion overlays, and a swipeable in-call tutorial. All externally consumable feature APIs are public; design tokens and resources remain centralized.

```swift
import HamsatPromotions

NotificationOnboardingView(
    locale: Locale(identifier: "ar"),
    onEnable: { /* request notification authorization */ },
    onLater: { /* persist deferral */ }
)

let model = PromotionViewModel(
    promotion: .extraCredit(
        deadline: Date().addingTimeInterval(12_000),
        locale: Locale(identifier: "ar")
    )
)
PromotionOverlay(
    viewModel: model,
    locale: Locale(identifier: "ar")
) { promotion in
    // Route to checkout.
}
```

The host app owns side effects (notification permission, navigation, analytics, and persistence). The package stays deterministic and preview/test friendly.

## Localization

The package uses Apple's modern String Catalog and `LocalizedStringResource` APIs, with English and Arabic translations and Arabic as its declared default localization. SwiftUI automatically mirrors the interface for right-to-left locales; the feature does not force a layout direction. Add languages and translations in `Resources/Localizable.xcstrings` using Xcode's String Catalog editor.

Pass `Locale(identifier: "ar")` to each public root view and localized model factory for explicit in-app language selection. Omitting it follows the system's current locale. Keep the same locale for a view and the model displayed by that view.

Custom `Promotion` and `TutorialPage` values accept already-localized strings, allowing the host app to supply server-driven or app-specific copy.

## Font

All feature typography uses the semantic tokens in `Theme.Typography`, configured for the `GE Dinar One` family with Dynamic Type scaling. The host app must include and register its licensed GE Dinar One font file. If the font is unavailable, the package safely falls back to the corresponding system font and weight.

## Canvas previews

Open the root `Package.swift` in Xcode, select the `HamsatPromotions` scheme and an iPhone simulator, then open `Sources/HamsatPromotions/Previews/HamsatPromotionsPreviews.swift`. Choose **Editor → Canvas** and click **Resume**. Arabic and English previews are included for onboarding, promotions, and the tutorial; no example app project is required.
