import SwiftUI

@main
struct AttackVpnApp: App {
    @StateObject private var controller = VpnController()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(controller)
                .preferredColorScheme(.dark)
        }
    }
}
