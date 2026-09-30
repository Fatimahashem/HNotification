import Combine
import Foundation

@MainActor
public final class PromotionViewModel: ObservableObject {
    @Published public private(set) var promotion: Promotion?
    @Published public private(set) var remainingTime: TimeInterval = 0

    private var timer: AnyCancellable?
    private let now: () -> Date

    public init(promotion: Promotion? = nil, now: @escaping () -> Date = Date.init) {
        self.promotion = promotion
        self.now = now
        updateRemainingTime()
        startTimerIfNeeded()
    }

    public var formattedRemainingTime: String? {
        guard promotion?.deadline != nil else { return nil }
        let total = max(Int(remainingTime), 0)
        return String(format: "%02d:%02d:%02d", total / 3_600, (total / 60) % 60, total % 60)
    }

    public func present(_ promotion: Promotion) {
        self.promotion = promotion
        updateRemainingTime()
        startTimerIfNeeded()
    }

    public func dismiss() {
        promotion = nil
        remainingTime = 0
        timer = nil
    }

    private func startTimerIfNeeded() {
        timer = nil
        guard promotion?.deadline != nil else { return }
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in self?.updateRemainingTime() }
    }

    private func updateRemainingTime() {
        guard let deadline = promotion?.deadline else {
            remainingTime = 0
            return
        }
        remainingTime = max(deadline.timeIntervalSince(now()), 0)
        if remainingTime == 0 { timer = nil }
    }
}

@MainActor
public final class TutorialViewModel: ObservableObject {
    @Published public var selectedIndex: Int
    public let pages: [TutorialPage]

    public init(
        pages: [TutorialPage]? = nil,
        selectedIndex: Int = 0,
        locale: Locale = .current
    ) {
        let pages = pages ?? TutorialPage.defaults(locale: locale)
        precondition(!pages.isEmpty, "Tutorial requires at least one page")
        self.pages = pages
        self.selectedIndex = min(max(selectedIndex, 0), pages.count - 1)
    }
}
