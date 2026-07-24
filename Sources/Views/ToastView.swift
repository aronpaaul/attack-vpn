import SwiftUI

struct ToastView: View {
    let message: ToastMessage

    @AppStorage("useLiquidGlass") private var useGlass = true

    var body: some View {
        HStack(spacing: 10) {
            Icon(message.kind.icon, size: 18, color: message.kind.accent)
            Text(message.text)
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(Palette.text)
                .lineLimit(2)
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 13)
        .modifier(ToastSkin(accent: message.kind.accent, useGlass: useGlass))
        .padding(.horizontal, 24)
    }
}

struct ToastSkin: ViewModifier {
    let accent: Color
    let useGlass: Bool

    @ViewBuilder
    func body(content: Content) -> some View {
        if useGlass, #available(iOS 26.0, *) {
            content.glassEffect(.regular.tint(accent.opacity(0.30)), in: Capsule())
        } else {
            content
                .background(accent.opacity(0.16), in: Capsule())
                .background(Palette.cardPress, in: Capsule())
        }
    }
}
