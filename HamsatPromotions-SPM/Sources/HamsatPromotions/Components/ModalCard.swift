import SwiftUI

public struct ModalCard<Content: View>: View {
    private let content: Content

    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    public var body: some View {
        content
            .padding(.horizontal, 24)
            .padding(.vertical, 32)
            .frame(maxWidth: 636)
            .background(Theme.Colors.surface)
            .clipShape(RoundedRectangle(cornerRadius: Theme.Radius.modal, style: .continuous))
    }
}
