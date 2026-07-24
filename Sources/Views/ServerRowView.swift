import SwiftUI

struct ServerRowView: View {
    let server: VpnServer
    let selected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 14) {
                Text(server.flag).font(.system(size: 30))
                VStack(alignment: .leading, spacing: 3) {
                    Text(server.country)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(Palette.textPrimary)
                    Text("\(server.city) · \(server.pingMs) ms")
                        .font(.system(size: 13))
                        .foregroundStyle(Palette.textMuted)
                }
                Spacer()
                PingBarsView(pingMs: server.pingMs)
                if selected {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(Palette.live)
                }
            }
            .padding(16)
            .background(Palette.surface, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
            .overlay {
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .stroke(selected ? Palette.live : Color.clear, lineWidth: 1.5)
            }
        }
        .buttonStyle(PressableStyle())
    }
}
