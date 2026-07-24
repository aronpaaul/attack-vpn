import SwiftUI

struct HeroOrbView: View {
    @EnvironmentObject private var vpn: VpnController
    let size: CGFloat
    @State private var progress: CGFloat = 0

    var body: some View {
        ZStack {
            Circle().stroke(Palette.track, lineWidth: 3)
            ringLayer
            Circle().fill(Palette.card).padding(26)
            core
        }
        .frame(width: size, height: size)
        .onChange(of: vpn.state) { _, s in update(s) }
        .onAppear { update(vpn.state) }
    }

    @ViewBuilder
    private var ringLayer: some View {
        if vpn.state.isOn {
            Circle().stroke(Palette.white, lineWidth: 3)
        } else {
            Circle()
                .trim(from: 0, to: progress)
                .stroke(Palette.white, style: StrokeStyle(lineWidth: 3, lineCap: .round))
                .rotationEffect(.degrees(-90))
        }
    }

    private var core: some View {
        VStack(spacing: 10) {
            Icon(vpn.state.isOn ? "shield-check" : "power", size: 44, color: Palette.white)
            if vpn.state.isOn {
                Text(TimeFormatting.clock(vpn.elapsed))
                    .font(.system(size: 26, weight: .heavy))
                    .foregroundStyle(Palette.text)
            } else {
                Text(vpn.state == .connecting ? "Connecting…" : "Tap to connect")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(Palette.muted)
            }
        }
    }

    private func update(_ s: ConnectionState) {
        switch s {
        case .connecting: withAnimation(.easeInOut(duration: 1.0)) { progress = 1 }
        case .connected: progress = 1
        default: withAnimation(.easeOut(duration: 0.3)) { progress = 0 }
        }
    }
}
