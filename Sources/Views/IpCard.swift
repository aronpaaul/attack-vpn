import SwiftUI
import UIKit

struct IpCard: View {
    @EnvironmentObject private var vpn: VpnController
    var showToast: (String) -> Void
    @State private var revealed = false

    var body: some View {
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 8) {
                Text("IP address")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(Palette.muted)
                ipText
                Text(revealed ? "Tap again to copy" : "Tap to reveal")
                    .font(.system(size: 11))
                    .foregroundStyle(Palette.muted)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .contentShape(Rectangle())
            .onTapGesture(perform: tap)

            Button(action: copy) {
                Icon("copy", size: 20, color: Palette.text)
                    .frame(width: 44, height: 44)
                    .background(Palette.cardPress, in: RoundedRectangle(cornerRadius: 14, style: .continuous))
            }
            .buttonStyle(.plain)
        }
        .cardStyle()
    }

    private var ipText: some View {
        let parts = vpn.publicIp.split(separator: ".").map(String.init)
        let ok = parts.count == 4
        return HStack(spacing: 2) {
            Text(ok ? parts[0] + "." : vpn.publicIp)
            if ok {
                Text(parts[1] + "." + parts[2]).blur(radius: revealed ? 0 : 7)
                Text("." + parts[3])
            }
        }
        .font(.system(size: 22, weight: .heavy))
        .foregroundStyle(Palette.text)
    }

    private func tap() {
        if !revealed { withAnimation(.easeOut(duration: 0.4)) { revealed = true } }
        else { copy() }
    }

    private func copy() {
        withAnimation { revealed = true }
        UIPasteboard.general.string = vpn.publicIp
        HapticsEngine.shared.tick()
        showToast("IP copied · \(vpn.publicIp)")
    }
}
