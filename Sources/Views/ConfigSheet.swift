import SwiftUI
import UIKit

struct ConfigSheet: View {
    @EnvironmentObject private var vpn: VpnController
    @Environment(\.dismiss) private var dismiss

    @State private var text = ""
    @State private var invalid = false
    @State private var showQR = false
    @State private var showShare = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 14) {
                    Text("Paste a vless:// key. It’s parsed on device and turned into a tunnel.")
                        .font(.system(size: 13)).foregroundStyle(Palette.muted)
                    TextEditor(text: $text)
                        .font(.system(size: 13, design: .monospaced))
                        .scrollContentBackground(.hidden)
                        .foregroundStyle(Palette.text)
                        .frame(height: 108)
                        .padding(12)
                        .modifier(GlassCard(cornerRadius: 16))
                    Button { text = UIPasteboard.general.string ?? text } label: {
                        HStack(spacing: 8) {
                            Icon("clipboard-paste", size: 16, color: Palette.text)
                            Text("Paste from clipboard").font(.system(size: 14, weight: .semibold))
                                .foregroundStyle(Palette.text)
                        }
                    }
                    .buttonStyle(.plain)
                    if invalid {
                        Text("Not a valid vless:// key")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundStyle(Color(red: 1, green: 0.42, blue: 0.45))
                    }
                    PrimaryButton(title: vpn.hasConfig ? "Replace key" : "Import key") { save() }
                    if vpn.hasConfig {
                        ConfigActions(onQR: { showQR = true },
                                      onExport: { showShare = true },
                                      onRemove: { vpn.removeConfig(); dismiss() })
                    }
                }
                .padding(20)
                .frame(maxWidth: 520)
                .frame(maxWidth: .infinity)
            }
            .scrollContentBackground(.hidden)
            .background(Palette.bg)
            .navigationTitle("Configuration")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { ToolbarItem(placement: .confirmationAction) { Button("Done") { dismiss() } } }
        }
        .onAppear { text = vpn.config?.raw ?? "" }
        .sheet(isPresented: $showQR) { QRSheet(text: vpn.config?.raw ?? "") }
        .sheet(isPresented: $showShare) { ShareSheet(items: [vpn.config?.raw ?? ""]) }
    }

    private func save() {
        if vpn.importKey(text) { HapticsEngine.shared.tick(); dismiss() }
        else { withAnimation { invalid = true } }
    }
}
