import SwiftUI

extension View {
    func cardStyle(padding: CGFloat = 16, radius: CGFloat = 20) -> some View {
        self
            .padding(padding)
            .modifier(GlassCard(cornerRadius: radius))
    }
}
