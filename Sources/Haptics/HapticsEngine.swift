import CoreHaptics
import Foundation

@MainActor
final class HapticsEngine {
    static let shared = HapticsEngine()

    private var engine: CHHapticEngine?

    private var enabled: Bool {
        let defaults = UserDefaults.standard
        return defaults.object(forKey: "haptics") == nil ? true : defaults.bool(forKey: "haptics")
    }

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
        guard enabled, supported, let pattern else { return }
        prepare()
        let player = try? engine?.makePlayer(with: pattern)
        try? player?.start(atTime: 0)
    }

    func tick() { play(HapticPatterns.tick()) }
    func connected() { play(HapticPatterns.connected()) }
    func disconnected() { play(HapticPatterns.disconnected()) }
}
