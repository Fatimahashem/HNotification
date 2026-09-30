import Foundation

public struct Promotion: Identifiable, Equatable, Sendable {
    public enum Artwork: String, Sendable {
        case bonusCredit = "BonusCredit"
        case limitedOffer = "LimitedOffer"
    }

    public let id: UUID
    public let artwork: Artwork
    public let title: String
    public let message: String
    public let deadline: Date?

    public init(
        id: UUID = UUID(),
        artwork: Artwork,
        title: String,
        message: String,
        deadline: Date? = nil
    ) {
        self.id = id
        self.artwork = artwork
        self.title = title
        self.message = message
        self.deadline = deadline
    }

    public static func extraCredit(
        deadline: Date? = nil,
        locale: Locale = .current
    ) -> Self {
        .init(
            artwork: .bonusCredit,
            title: locale.localizedString(
                "promotion.extra_credit.title",
                defaultValue: "25% extra when you buy Hamsat credit"
            ),
            message: localizedPromotionMessage(locale: locale),
            deadline: deadline
        )
    }

    public static func fiveDollarOffer(
        deadline: Date? = nil,
        locale: Locale = .current
    ) -> Self {
        .init(
            artwork: .limitedOffer,
            title: locale.localizedString(
                "promotion.five_dollar.title",
                defaultValue: "Buy 20 minutes for only $5"
            ),
            message: localizedPromotionMessage(locale: locale),
            deadline: deadline
        )
    }

    private static func localizedPromotionMessage(locale: Locale) -> String {
        locale.localizedString(
            "promotion.message",
            defaultValue: "Don't miss out—recharge now"
        )
    }
}

public struct TutorialPage: Identifiable, Equatable, Sendable {
    public enum Artwork: String, Sendable {
        case announcement = "Announcement"
        case inCallControl = "InCallControl"
        case minutePackages = "MinutePackages"
    }

    public let id: String
    public let artwork: Artwork
    public let title: String
    public let message: String

    public init(id: String? = nil, artwork: Artwork, title: String, message: String) {
        self.id = id ?? artwork.rawValue
        self.artwork = artwork
        self.title = title
        self.message = message
    }

    public static var defaults: [Self] { defaults(locale: .current) }

    public static func defaults(locale: Locale) -> [Self] {
        [
            .init(
                artwork: .minutePackages,
                title: localizedHowToTitle(locale: locale),
                message: locale.localizedString(
                    "tutorial.packages.body",
                    defaultValue: "Choose the package you want and continue your call!"
                )
            ),
            .init(
                artwork: .inCallControl,
                title: localizedHowToTitle(locale: locale),
                message: locale.localizedString(
                    "tutorial.control.body",
                    defaultValue: "During your call, tap the button shown above"
                )
            ),
            .init(
                artwork: .announcement,
                title: locale.localizedString(
                    "tutorial.announcement.title",
                    defaultValue: "New feature"
                ),
                message: locale.localizedString(
                    "tutorial.announcement.body",
                    defaultValue: "You can now recharge your balance during a call"
                )
            )
        ]
    }

    private static func localizedHowToTitle(locale: Locale) -> String {
        locale.localizedString(
            "tutorial.how_to.title",
            defaultValue: "How to use"
        )
    }
}
