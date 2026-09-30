import Foundation

extension Locale {
    func localizedResource(
        _ key: StaticString,
        defaultValue: String.LocalizationValue
    ) -> LocalizedStringResource {
        LocalizedStringResource(
            key,
            defaultValue: defaultValue,
            locale: self,
            bundle: #bundle
        )
    }

    func localizedString(
        _ key: StaticString,
        defaultValue: String.LocalizationValue
    ) -> String {
        String(localized: localizedResource(key, defaultValue: defaultValue))
    }
}
