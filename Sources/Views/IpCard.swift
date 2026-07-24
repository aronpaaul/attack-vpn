import SwiftUI
import UIKit

struct IpCard: View {
    @EnvironmentObject private var vpn: VpnController
    var showToast: (String) -> Void

    @AppStorage("showFullIp") private var showFullIp = false
    @State private var revealed = false

    var body: some View {
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 8) {
                Text("IP address")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(Palette.muted)
                content
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .contentShape(Rectangle())
            .onTapGesture(perform: tap)

            if vpn.publicIp != nil {
                Button(action: copy) {
                    Icon("copy", size: 20, color: Palette.text)
                        .frame(width: 44, height: 44)
                        .modifier(GlassCard(cornerRadius: 14))
                }
                .buttonStyle(.plain)
            }
        }
        .cardStyle()
    }

    @ViewBuilder
    private var content: some View {
        if let ip = vpn.publicIp {
            let parts = ip.split(separator: ".").map(String.init)
            let shown = revealed || showFullIp
            HStack(spacing: 2) {
                Text(parts.count == 4 ? parts[0] + "." : ip)
                if parts.count == 4 {
                    Text(parts[1] + "." + parts[2]).blur(radius: shown ? 0 : 7)
                    Text("." + parts[3])
                }
            }
            .font(.system(size: 22, weight: .heavy))
            .foregroundStyle(Palette.text)
            Text(shown ? "Tap to copy" : "Tap to reveal")
                .font(.system(size: 11)).foregroundStyle(Palette.muted)
        } else {
            Text("—").font(.system(size: 22, weight: .heavy)).foregroundStyle(Palette.muted)
            Text("Connect to reveal").font(.system(size: 11)).foregroundStyle(Palette.muted)
        }
    }

    private func tap() {
        guard vpn.publicIp != nil else { return }
        if revealed || showFullIp { copy() }
        else { withAnimation(.easeOut(duration: 0.4)) { revealed = true } }
    }

    private func copy() {
        guard let ip = vpn.publicIp else { return }
        withAnimation { revealed = true }
        UIPasteboard.general.string = ip
        HapticsEngine.shared.tick()
        showToast("IP copied · \(ip)")
    }
}
