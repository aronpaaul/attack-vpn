import SwiftUI

struct ConnectControl: View {
    @EnvironmentObject private var controller: VpnController
    @State private var progress: CGFloat = 0
    @State private var holding = false
    @State private var latched = false
    @State private var holdTask: Task<Void, Never>?

    private let holdDuration: Double = 0.85

    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0, to: progress)
                .stroke(Palette.accent(for: controller.state), style: StrokeStyle(lineWidth: 6, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .opacity(holding ? 1 : 0)
                .padding(6)

            VStack(spacing: 8) {
                Image(systemName: iconName)
                    .font(.system(size: 34, weight: .semibold))
                Text(actionLabel)
                    .font(.system(size: 13, weight: .semibold))
                    .textCase(.uppercase)
                    .tracking(2)
            }
            .foregroundStyle(Palette.textPrimary)
        }
        .contentShape(Circle())
        .gesture(holdGesture)
        .animation(.easeOut(duration: 0.2), value: holding)
    }

    private var holdGesture: some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged { _ in if !holding && !latched { beginHold() } }
            .onEnded { _ in latched = false; cancelHold() }
    }

    private func beginHold() {
        guard !controller.state.isBusy else { return }
        holding = true
        withAnimation(.linear(duration: holdDuration)) { progress = 1 }
        holdTask = Task { @MainActor in
            let steps = 9
            for _ in 0..<steps {
                try? await Task.sleep(nanoseconds: UInt64(holdDuration / Double(steps) * 1_000_000_000))
                if Task.isCancelled { return }
                HapticsEngine.shared.tick()
            }
            latched = true
            holding = false
            progress = 0
            controller.toggle()
        }
    }

    private func cancelHold() {
        holdTask?.cancel()
        holdTask = nil
        holding = false
        withAnimation(.easeOut(duration: 0.2)) { progress = 0 }
    }

    private var iconName: String {
        switch controller.state {
        case .disconnected: return "power"
        case .connecting, .disconnecting: return "hourglass"
        case .connected: return "checkmark.shield.fill"
        }
    }

    private var actionLabel: String {
        switch controller.state {
        case .disconnected: return "Hold to connect"
        case .connecting: return "Connecting"
        case .connected: return "Hold to stop"
        case .disconnecting: return "Stopping"
        }
    }
}
