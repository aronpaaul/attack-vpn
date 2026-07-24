import SwiftUI

struct GlossBackground: View {
    var body: some View {
        ZStack {
            Palette.bg
            RadialGradient(
                colors: [Color(red: 0.33, green: 0.45, blue: 0.95).opacity(0.20), .clear],
                center: UnitPoint(x: 0.5, y: 0.10),
                startRadius: 0,
                endRadius: 430
            )
            RadialGradient(
                colors: [Color(red: 0.45, green: 0.75, blue: 1.0).opacity(0.06), .clear],
                center: UnitPoint(x: 0.85, y: 0.32),
                startRadius: 0,
                endRadius: 300
            )
            RadialGradient(
                colors: [Color.white.opacity(0.05), .clear],
                center: UnitPoint(x: 0.5, y: 1.02),
                startRadius: 0,
                endRadius: 360
            )
        }
        .ignoresSafeArea()
    }
}
