import SwiftUI

struct BackgroundView: View {
    let state: ConnectionState

    var body: some View {
        TimelineView(.animation(minimumInterval: 1.0 / 30.0, paused: false)) { timeline in
            let t = timeline.date.timeIntervalSinceReferenceDate
            Canvas { context, size in
                context.fill(Path(CGRect(origin: .zero, size: size)), with: .color(Palette.background))
                drawGlow(&context, size: size, time: t)
            }
            .ignoresSafeArea()
        }
    }

    private func drawGlow(_ context: inout GraphicsContext, size: CGSize, time: Double) {
        let accent = Palette.accent(for: state)
        var layer = context
        layer.addFilter(.blur(radius: 90))
        for i in 0..<3 {
            let phase = time * 0.22 + Double(i) * 2.1
            let x = size.width * (0.5 + 0.32 * cos(phase))
            let y = size.height * (0.4 + 0.3 * sin(phase * 0.8))
            let r = size.width * 0.42
            let rect = CGRect(x: x - r, y: y - r, width: r * 2, height: r * 2)
            let opacity = (state.isOn ? 0.42 : 0.24) - Double(i) * 0.05
            layer.fill(Circle().path(in: rect), with: .color(accent.opacity(opacity)))
        }
    }
}
