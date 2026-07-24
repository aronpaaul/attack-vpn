import SwiftUI

struct RootView: View {
    @EnvironmentObject private var controller: VpnController

    var body: some View {
        ZStack {
            BackgroundView(state: controller.state)
            HomeView()
        }
        .task {
            HapticsEngine.shared.prepare()
        }
    }
}
