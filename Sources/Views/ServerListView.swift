import SwiftUI

struct ServerListView: View {
    @EnvironmentObject private var controller: VpnController
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                header
                ForEach(SampleServers.all) { server in
                    ServerRowView(server: server, selected: server == controller.server) {
                        HapticsEngine.shared.tick()
                        controller.select(server)
                        dismiss()
                    }
                }
            }
            .padding(20)
        }
        .background(Palette.background)
    }

    private var header: some View {
        HStack {
            Text("Choose location")
                .font(.system(size: 22, weight: .bold))
                .foregroundStyle(Palette.textPrimary)
            Spacer()
        }
        .padding(.bottom, 4)
    }
}
