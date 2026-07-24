import SwiftUI

struct ToastView: View {
    let text: String

    var body: some View {
        Text(text)
            .font(.system(size: 13, weight: .semibold))
            .foregroundStyle(Palette.text)
            .padding(.horizontal, 18)
            .padding(.vertical, 11)
            .background(Palette.cardPress, in: Capsule())
            .transition(.move(edge: .bottom).combined(with: .opacity))
    }
}
