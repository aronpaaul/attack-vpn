import SwiftUI

struct ConfigCard: View {
    @EnvironmentObject private var vpn: VpnController
    var onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            if let config = vpn.config {
                HStack(spacing: 12) {
                    Text(vpn.flag ?? "🌐").font(.system(size: 22))
                    VStack(alignment: .leading, spacing: 2) {
                        Text(config.name)
                            .font(.system(size: 15, weight: .bold))
                            .foregroundStyle(Palette.text)
                        Text(config.maskedRaw)
                            .font(.system(size: 12))
                            .foregroundStyle(Palette.muted)
                            .lineLimit(1)
                    }
                    Spacer(minLength: 8)
                    Text(config.securityTag)
                        .font(.system(size: 10, weight: .heavy))
                        .tracking(0.6)
                        .foregroundStyle(Palette.muted)
                    Icon("chevrons-up-down", size: 18, color: Palette.muted)
                }
                .cardStyle()
            } else {
                HStack(spacing: 12) {
                    Icon("plus", size: 20, color: Palette.text)
                    Text("Add configuration")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundStyle(Palette.text)
                    Spacer()
                    Text("vless://")
                        .font(.system(size: 12, design: .monospaced))
                        .foregroundStyle(Palette.muted)
                }
                .cardStyle()
            }
        }
        .buttonStyle(.plain)
    }
}
