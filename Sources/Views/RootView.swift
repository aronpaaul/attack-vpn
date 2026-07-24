import SwiftUI

struct RootView: View {
    @EnvironmentObject private var vpn: VpnController
    @AppStorage("connectOnLaunch") private var connectOnLaunch = false

    var body: some View {
        ZStack {
            GlossBackground()
            HomeView()
        }
        .task {
            HapticsEngine.shared.prepare()
            if connectOnLaunch, vpn.hasConfig, vpn.state == .disconnected {
                vpn.connect()
            }
        }
    }
}
