import SwiftUI

struct ConnectionInfoView: View {
    let state: ConnectionState
    let elapsed: TimeInterval
    let publicIp: String

    var body: some View {
        HStack(spacing: 12) {
            infoTile(title: "Session", value: state.isOn ? TimeFormatting.clock(elapsed) : "--:--")
            infoTile(title: "IP", value: state.isOn ? publicIp : "hidden")
        }
        .padding(.vertical, 18)
    }

    private func infoTile(title: String, value: String) -> some View {
        VStack(spacing: 6) {
            Text(title)
                .font(.system(size: 12, weight: .semibold))
                .tracking(1.5)
                .foregroundStyle(Palette.textMuted)
            Text(value)
                .font(.system(size: 18, weight: .semibold, design: .monospaced))
                .foregroundStyle(Palette.textPrimary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .background(Palette.surface, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
    }
}
