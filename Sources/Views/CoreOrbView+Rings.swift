import SwiftUI

extension CoreOrbView {
    func drawRings(_ context: inout GraphicsContext, center: CGPoint, radius: CGFloat, time: Double) {
        let speed = state.isBusy ? 2.4 : 0.6
        for i in 0..<3 {
            let rr = radius * (0.62 + CGFloat(i) * 0.13)
            let direction: Double = i % 2 == 0 ? 1 : -1
            let start = Angle(radians: time * speed * direction + Double(i))
            let end = Angle(radians: start.radians + .pi / 2 + Double(i) * 0.7)
            var path = Path()
            path.addArc(center: center, radius: rr, startAngle: start, endAngle: end, clockwise: false)
            context.stroke(path, with: .color(accent.opacity(0.5 - Double(i) * 0.12)),
                           style: StrokeStyle(lineWidth: 3 - CGFloat(i) * 0.6, lineCap: .round))
        }
    }

    func drawPulses(_ context: inout GraphicsContext, center: CGPoint, radius: CGFloat, time: Double) {
        guard state.isOn else { return }
        let count = 3
        for i in 0..<count {
            let phase = (time * 0.5 + Double(i) / Double(count)).truncatingRemainder(dividingBy: 1)
            let rr = radius * (0.42 + CGFloat(phase) * 0.55)
            let rect = CGRect(x: center.x - rr, y: center.y - rr, width: rr * 2, height: rr * 2)
            context.stroke(Circle().path(in: rect), with: .color(accent.opacity((1 - phase) * 0.4)), lineWidth: 2)
        }
    }
}
