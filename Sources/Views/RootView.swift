import SwiftUI

struct RootView: View {
    var body: some View {
        ZStack {
            Palette.bg.ignoresSafeArea()
            HomeView()
        }
        .task { HapticsEngine.shared.prepare() }
    }
}
