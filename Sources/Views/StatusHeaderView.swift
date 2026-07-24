import SwiftUI

struct StatusHeaderView: View {
    let state: ConnectionState

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 8) {
                Image(systemName: "bolt.shield.fill")
                    .foregroundStyle(Palette.accent(for: state))
                Text("ATTACK VPN")
                    .font(.system(size: 16, weight: .heavy))
                    .tracking(4)
                    .foregroundStyle(Palette.textPrimary)
            }
            HStack(spacing: 8) {
                Circle()
                    .fill(Palette.accent(for: state))
                    .frame(width: 8, height: 8)
                Text(state.title)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(Palette.textMuted)
            }
        }
    }
}
