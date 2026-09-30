import XCTest
@testable import HamsatPromotions

final class HamsatPromotionsTests: XCTestCase {
    @MainActor
    func testCountdownFormatting() {
        let now = Date(timeIntervalSince1970: 1_000)
        let promotion = Promotion.extraCredit(deadline: now.addingTimeInterval(3_661))
        let subject = PromotionViewModel(promotion: promotion, now: { now })
        XCTAssertEqual(subject.formattedRemainingTime, "01:01:01")
    }

    @MainActor
    func testDismissClearsPromotion() {
        let subject = PromotionViewModel(promotion: .extraCredit())
        subject.dismiss()
        XCTAssertNil(subject.promotion)
    }

    @MainActor
    func testTutorialIndexIsClamped() {
        let subject = TutorialViewModel(selectedIndex: 99)
        XCTAssertEqual(subject.selectedIndex, TutorialPage.defaults.count - 1)
    }

    func testLanguageCanBePassedToDefaultModels() {
        let locale = Locale(identifier: "ar")
        let promotion = Promotion.extraCredit(locale: locale)
        XCTAssertEqual(promotion.message, "لا تفوّت الفرصة، اشحن الآن")
    }
}
