import Foundation

extension Locale {
    func localizedString(
        _ key: StaticString,
        defaultValue: String.LocalizationValue
    ) -> String {
        String(
            localized: key,
            defaultValue: defaultValue,
            bundle: localizedModuleBundle,
            locale: self
        )
    }

    private var localizedModuleBundle: Bundle {
        guard
            let languageCode,
            let path = Bundle.module.path(forResource: languageCode, ofType: "lproj"),
            let bundle = Bundle(path: path)
        else {
            return .module
        }

        return bundle
    }
}
