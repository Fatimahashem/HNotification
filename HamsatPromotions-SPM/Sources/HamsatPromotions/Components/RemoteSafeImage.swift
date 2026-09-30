import SwiftUI

/// Loads package artwork by semantic name and prevents accidental main-bundle lookup.
public struct FeatureImage: View {
    private let name: String
    private let contentMode: ContentMode

    public init(_ name: String, contentMode: ContentMode = .fit) {
        self.name = name
        self.contentMode = contentMode
    }

    public var body: some View {
        Image(name, bundle: .module)
            .resizable()
            .aspectRatio(contentMode: contentMode)
            .accessibilityHidden(true)
    }
}
