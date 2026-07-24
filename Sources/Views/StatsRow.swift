import SwiftUI

struct StatsRow: View {
    @EnvironmentObject private var vpn: VpnController

    var body: some View {
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 10) {
                label("gauge", "Ping")
                pingValue
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .cardStyle()

            VStack(alignment: .leading, spacing: 10) {
                label("globe", "Location")
                locationValue
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .cardStyle()
        }
    }

    @ViewBuilder
    private var pingValue: some View {
        if let ping = vpn.ping {
            HStack(alignment: .firstTextBaseline, spacing: 3) {
                Text("\(ping)")
                    .font(.system(size: 28, weight: .heavy))
                    .foregroundStyle(Palette.text)
                    .contentTransition(.numericText())
                Text("ms")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundStyle(Palette.muted)
            }
        } else {
            Text("—").font(.system(size: 28, weight: .heavy)).foregroundStyle(Palette.muted)
        }
    }

    @ViewBuilder
    private var locationValue: some View {
        if let country = vpn.country, let flag = vpn.flag {
            HStack(spacing: 9) {
                Text(flag).font(.system(size: 22))
                Text(country).font(.system(size: 17, weight: .bold)).foregroundStyle(Palette.text)
                    .lineLimit(1).minimumScaleFactor(0.7)
            }
        } else {
            Text("—").font(.system(size: 20, weight: .heavy)).foregroundStyle(Palette.muted)
        }
    }

    private func label(_ icon: String, _ title: String) -> some View {
        HStack(spacing: 7) {
            Icon(icon, size: 14, color: Palette.muted)
            Text(title).font(.system(size: 12, weight: .semibold)).foregroundStyle(Palette.muted)
        }
    }
}
