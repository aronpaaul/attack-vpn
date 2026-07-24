import SwiftUI

struct CoreOrbView: View {
    let state: ConnectionState
    let accent: Color

    var body: some View {
        TimelineView(.animation) { timeline in
            let t = timeline.date.timeIntervalSinceReferenceDate
            Canvas { context, size in
                let center = CGPoint(x: size.width / 2, y: size.height / 2)
                let radius = min(size.width, size.height) / 2
                drawBase(&context, center: center, radius: radius)
                drawPulses(&context, center: center, radius: radius, time: t)
                drawRings(&context, center: center, radius: radius, time: t)
                drawCore(&context, center: center, radius: radius, time: t)
            }
        }
    }

    private func drawBase(_ context: inout GraphicsContext, center: CGPoint, radius: CGFloat) {
        let inset = radius * 0.2
        let rect = CGRect(x: center.x - radius + inset, y: center.y - radius + inset,
                          width: (radius - inset) * 2, height: (radius - inset) * 2)
        var glow = context
        glow.addFilter(.blur(radius: 40))
        glow.fill(Circle().path(in: rect), with: .color(accent.opacity(state.isOn ? 0.4 : 0.2)))
    }

    private func drawCore(_ context: inout GraphicsContext, center: CGPoint, radius: CGFloat, time: Double) {
        let breathe = 1 + 0.05 * sin(time * (state.isBusy ? 6 : 2))
        let r = radius * 0.42 * breathe
        let rect = CGRect(x: center.x - r, y: center.y - r, width: r * 2, height: r * 2)
        let shading = GraphicsContext.Shading.radialGradient(
            Gradient(colors: [accent.opacity(0.95), accent.opacity(0.12)]),
            center: center, startRadius: 0, endRadius: r)
        context.fill(Circle().path(in: rect), with: shading)
        context.stroke(Circle().path(in: rect), with: .color(accent.opacity(0.6)), lineWidth: 1.5)
    }
}
