import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var controller: VpnController
    @Environment(\.horizontalSizeClass) private var sizeClass
    @State private var showServers = false

    private var orbSize: CGFloat {
        sizeClass == .regular ? 360 : 280
    }

    var body: some View {
        VStack(spacing: 0) {
            StatusHeaderView(state: controller.state)
                .padding(.top, 24)

            Spacer(minLength: 12)

            CoreOrbView(state: controller.state, accent: Palette.accent(for: controller.state))
                .frame(width: orbSize, height: orbSize)
                .overlay { ConnectControl().frame(width: orbSize, height: orbSize) }

            Spacer(minLength: 12)

            ConnectionInfoView(state: controller.state, elapsed: controller.elapsed, publicIp: controller.publicIp)

            ServerPillView(server: controller.server) {
                HapticsEngine.shared.tick()
                showServers = true
            }
            .padding(.bottom, 28)
        }
        .frame(maxWidth: 540)
        .padding(.horizontal, 28)
        .frame(maxWidth: .infinity)
        .onChange(of: controller.state) { _, newValue in
            switch newValue {
            case .connecting: HapticsEngine.shared.connectRamp()
            case .connected: HapticsEngine.shared.connected()
            case .disconnecting: HapticsEngine.shared.disconnected()
            case .disconnected: break
            }
        }
        .sheet(isPresented: $showServers) {
            ServerListView()
                .presentationDetents([.large, .medium])
                .presentationDragIndicator(.visible)
        }
    }
}
