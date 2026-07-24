import SwiftUI

struct ToggleRow: View {
    let title: String
    @Binding var isOn: Bool
    var enabled: Bool = true
    var note: String? = nil

    var body: some View {
        HStack(spacing: 8) {
            Text(title)
                .font(.system(size: 15, weight: .semibold))
                .foregroundStyle(enabled ? Palette.text : Palette.muted)
            if let note {
                Text(note)
                    .font(.system(size: 11, weight: .bold))
                    .foregroundStyle(Palette.muted)
            }
            Spacer()
            Toggle("", isOn: $isOn)
                .labelsHidden()
                .disabled(!enabled)
                .tint(Palette.white)
        }
        .padding(.vertical, 4)
    }
}
