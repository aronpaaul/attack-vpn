import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var vpn: VpnController
    @Environment(\.horizontalSizeClass) private var sizeClass
    @State private var showConfig = false
    @State private var showSettings = false
    @State private var toast: ToastMessage?

    private var orbSize: CGFloat { sizeClass == .regular ? 320 : 230 }

    var body: some View {
        VStack(spacing: 16) {
            TopBar { showSettings = true }
            Text(vpn.hasConfig ? vpn.state.statusLabel : "No configuration")
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(vpn.state.isOn ? Palette.text : Palette.muted)
                .padding(.top, 6)
            HeroOrbView(size: orbSize)
                .contentShape(Circle())
                .onTapGesture { heroTap() }
            StatsRow()
            IpCard(report: { toast = $0 })
            ConfigCard { showConfig = true }
            Spacer(minLength: 8)
        }
        .padding(.horizontal, 20)
        .padding(.top, 12)
        .frame(maxWidth: 520)
        .frame(maxWidth: .infinity)
        .onChange(of: vpn.state) { _, s in
            if s == .connected { HapticsEngine.shared.connected() }
            else if s == .connecting || s == .disconnecting { HapticsEngine.shared.tick() }
        }
        .sheet(isPresented: $showConfig) { ConfigSheet() }
        .sheet(isPresented: $showSettings) { SettingsSheet() }
        .toast($toast)
    }

    private func heroTap() {
        if vpn.hasConfig { vpn.toggle() } else { showConfig = true }
    }
}
