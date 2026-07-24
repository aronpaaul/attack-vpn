import SwiftUI

struct TopBar: View {
    let onSettings: () -> Void

    var body: some View {
        HStack(spacing: 6) {
            Text("Attack").foregroundStyle(Palette.text)
            Text("VPN").foregroundStyle(Palette.muted)
            Spacer()
            Button(action: onSettings) {
                Icon("settings-2", size: 22, color: Palette.text)
                    .frame(width: 40, height: 40)
                    .modifier(GlassCard(cornerRadius: 13))
            }
            .buttonStyle(.plain)
        }
        .font(.system(size: 19, weight: .heavy))
    }
}
