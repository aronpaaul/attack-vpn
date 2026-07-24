import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var vpn: VpnController
    @Environment(\.horizontalSizeClass) private var sizeClass
    @State private var showPaste = false
    @State private var toast: String?

    private var orbSize: CGFloat { sizeClass == .regular ? 320 : 230 }

    var body: some View {
        VStack(spacing: 16) {
            TopBar()
            Text(vpn.state.statusLabel)
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(vpn.state.isOn ? Palette.text : Palette.muted)
                .padding(.top, 6)
            HeroOrbView(size: orbSize)
                .contentShape(Circle())
                .onTapGesture { vpn.toggle() }
            StatsRow()
            IpCard(showToast: { toast = $0 })
            ConfigCard { showPaste = true }
            Spacer(minLength: 8)
            Button(vpn.state.isOn ? "Disconnect" : "Connect") { vpn.toggle() }
                .buttonStyle(WhiteButtonStyle())
        }
        .padding(.horizontal, 20)
        .padding(.top, 12)
        .frame(maxWidth: 520)
        .frame(maxWidth: .infinity)
        .onChange(of: vpn.state) { _, s in
            if s == .connected { HapticsEngine.shared.connected() }
            else if s == .connecting || s == .disconnecting { HapticsEngine.shared.tick() }
        }
        .onChange(of: toast) { _, v in
            guard v != nil else { return }
            Task { try? await Task.sleep(nanoseconds: 1_500_000_000); toast = nil }
        }
        .sheet(isPresented: $showPaste) { PasteSheet() }
        .overlay(alignment: .bottom) {
            if let toast { ToastView(text: toast).padding(.bottom, 96) }
        }
        .animation(.easeInOut(duration: 0.25), value: toast)
    }
}
