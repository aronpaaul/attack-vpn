import SwiftUI

struct PasteSheet: View {
    @EnvironmentObject private var vpn: VpnController
    @Environment(\.dismiss) private var dismiss
    @State private var text = ""
    @State private var invalid = false

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Add configuration")
                .font(.system(size: 20, weight: .heavy))
                .foregroundStyle(Palette.text)
            Text("Paste a vless:// key. It’s parsed on device and turned into a tunnel.")
                .font(.system(size: 13))
                .foregroundStyle(Palette.muted)
            TextEditor(text: $text)
                .font(.system(size: 13, design: .monospaced))
                .scrollContentBackground(.hidden)
                .foregroundStyle(Palette.text)
                .frame(height: 104)
                .padding(12)
                .background(Palette.card, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
            if invalid {
                Text("Not a valid vless:// key")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(Color(red: 1, green: 0.42, blue: 0.45))
            }
            Button("Save configuration") { save() }
                .buttonStyle(WhiteButtonStyle())
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Palette.bg2)
        .presentationDetents([.height(360)])
        .presentationDragIndicator(.visible)
    }

    private func save() {
        if vpn.apply(text) {
            HapticsEngine.shared.tick()
            dismiss()
        } else {
            withAnimation { invalid = true }
        }
    }
}
