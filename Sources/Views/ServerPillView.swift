import SwiftUI

struct ServerPillView: View {
    let server: VpnServer
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 14) {
                Text(server.flag).font(.system(size: 28))
                VStack(alignment: .leading, spacing: 2) {
                    Text(server.country)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(Palette.textPrimary)
                    Text(server.city)
                        .font(.system(size: 13))
                        .foregroundStyle(Palette.textMuted)
                }
                Spacer()
                Image(systemName: "chevron.up.chevron.down")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(Palette.textMuted)
            }
            .padding(.horizontal, 18)
            .padding(.vertical, 14)
            .background(Palette.surface, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
        }
        .buttonStyle(PressableStyle())
    }
}
