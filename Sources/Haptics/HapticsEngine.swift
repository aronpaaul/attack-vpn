import CoreHaptics

@MainActor
final class HapticsEngine {
    static let shared = HapticsEngine()

    private var engine: CHHapticEngine?

    private var supported: Bool {
        CHHapticEngine.capabilitiesForHardware().supportsHaptics
    }

    func prepare() {
        guard supported, engine == nil else { return }
        engine = try? CHHapticEngine()
        engine?.isAutoShutdownEnabled = true
        engine?.resetHandler = { [weak self] in try? self?.engine?.start() }
        try? engine?.start()
    }

    func play(_ pattern: CHHapticPattern?) {
        guard supported, let pattern else { return }
        prepare()
        let player = try? engine?.makePlayer(with: pattern)
        try? player?.start(atTime: 0)
    }

    func tick() { play(HapticPatterns.tick()) }
    func connectRamp() { play(HapticPatterns.connectRamp()) }
    func connected() { play(HapticPatterns.connected()) }
    func disconnected() { play(HapticPatterns.disconnected()) }
}
