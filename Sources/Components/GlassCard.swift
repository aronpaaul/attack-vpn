import SwiftUI

struct GlassCard: ViewModifier {
    var cornerRadius: CGFloat = 20

    @AppStorage("useLiquidGlass") private var useGlass = true

    @ViewBuilder
    func body(content: Content) -> some View {
        if useGlass, #available(iOS 26.0, *) {
            content.glassEffect(.regular, in: RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
        } else {
            content.background(Palette.card, in: RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
        }
    }
}
