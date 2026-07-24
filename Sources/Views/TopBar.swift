import SwiftUI

struct TopBar: View {
    var body: some View {
        HStack(spacing: 6) {
            Text("Attack").foregroundStyle(Palette.text)
            Text("VPN").foregroundStyle(Palette.muted)
            Spacer()
            Icon("settings-2", size: 24, color: Palette.muted)
        }
        .font(.system(size: 19, weight: .heavy))
    }
}
