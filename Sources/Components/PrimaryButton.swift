import SwiftUI

struct PrimaryButton: View {
    let title: String
    let action: () -> Void

    @AppStorage("useLiquidGlass") private var useGlass = true

    var body: some View {
        if useGlass, #available(iOS 26.0, *) {
            Button(action: action) { label.foregroundStyle(Palette.text) }
                .buttonStyle(.plain)
                .glassEffect(.regular.interactive(), in: RoundedRectangle(cornerRadius: 18, style: .continuous))
        } else {
            Button(action: action) { label }
                .buttonStyle(WhiteButtonStyle())
        }
    }

    private var label: some View {
        Text(title)
            .font(.system(size: 16, weight: .bold))
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
    }
}
