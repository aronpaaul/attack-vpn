import SwiftUI

struct ConfigActions: View {
    let onQR: () -> Void
    let onExport: () -> Void
    let onRemove: () -> Void

    private let danger = Color(red: 1, green: 0.42, blue: 0.45)

    var body: some View {
        HStack(spacing: 12) {
            item("qr-code", "QR", color: Palette.text, action: onQR)
            item("share-2", "Export", color: Palette.text, action: onExport)
            item("trash-2", "Remove", color: danger, action: onRemove)
        }
    }

    private func item(_ icon: String, _ title: String, color: Color, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Icon(icon, size: 22, color: color)
                Text(title).font(.system(size: 12, weight: .semibold)).foregroundStyle(Palette.muted)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .modifier(GlassCard(cornerRadius: 16))
        }
        .buttonStyle(.plain)
    }
}
