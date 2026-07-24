import SwiftUI

struct SettingsSheet: View {
    @EnvironmentObject private var vpn: VpnController
    @Environment(\.dismiss) private var dismiss

    @AppStorage("useLiquidGlass") private var useGlass = true
    @AppStorage("haptics") private var haptics = true
    @AppStorage("showFullIp") private var showFullIp = false
    @AppStorage("connectOnLaunch") private var connectOnLaunch = false

    private var glassAvailable: Bool {
        if #available(iOS 26.0, *) { return true } else { return false }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 12) {
                    VStack(spacing: 6) {
                        ToggleRow(title: "Liquid Glass", isOn: $useGlass,
                                  enabled: glassAvailable, note: glassAvailable ? nil : "iOS 26+")
                        Divider().overlay(Palette.track)
                        ToggleRow(title: "Haptics", isOn: $haptics)
                        Divider().overlay(Palette.track)
                        ToggleRow(title: "Show full IP", isOn: $showFullIp)
                        Divider().overlay(Palette.track)
                        ToggleRow(title: "Connect on launch", isOn: $connectOnLaunch)
                    }
                    .cardStyle()

                    if vpn.hasConfig {
                        Button { vpn.removeConfig(); dismiss() } label: {
                            Text("Remove configuration")
                                .font(.system(size: 15, weight: .bold))
                                .foregroundStyle(Color(red: 1, green: 0.42, blue: 0.45))
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.plain)
                        .cardStyle()
                    }

                    Text("Attack VPN · 0.3.2\nVLESS over sing-box · UI preview")
                        .font(.system(size: 12))
                        .multilineTextAlignment(.center)
                        .foregroundStyle(Palette.muted)
                        .padding(.top, 4)
                }
                .padding(20)
                .frame(maxWidth: 520)
                .frame(maxWidth: .infinity)
            }
            .scrollContentBackground(.hidden)
            .background(Palette.bg)
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { ToolbarItem(placement: .confirmationAction) { Button("Done") { dismiss() } } }
        }
    }
}
