import SwiftUI

struct StatsRow: View {
    @EnvironmentObject private var vpn: VpnController

    var body: some View {
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 10) {
                label("gauge", "Ping")
                HStack(alignment: .firstTextBaseline, spacing: 3) {
                    Text("\(vpn.pingMs)")
                        .font(.system(size: 28, weight: .heavy))
                        .foregroundStyle(Palette.text)
                    Text("ms")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundStyle(Palette.muted)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .cardStyle()

            VStack(alignment: .leading, spacing: 10) {
                label("globe", "Location")
                HStack(spacing: 9) {
                    Text(vpn.flag).font(.system(size: 22))
                    Text(vpn.country)
                        .font(.system(size: 17, weight: .bold))
                        .foregroundStyle(Palette.text)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .cardStyle()
        }
    }

    private func label(_ icon: String, _ title: String) -> some View {
        HStack(spacing: 7) {
            Icon(icon, size: 14, color: Palette.muted)
            Text(title)
                .font(.system(size: 12, weight: .semibold))
                .foregroundStyle(Palette.muted)
        }
    }
}
