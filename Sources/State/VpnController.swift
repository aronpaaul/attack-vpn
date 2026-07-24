import SwiftUI
import Combine

@MainActor
final class VpnController: ObservableObject {
    @Published var state: ConnectionState = .disconnected
    @Published private(set) var config: VlessConfig?
    @Published var elapsed: TimeInterval = 0
    @Published var ping: Int?

    private var stats: ConfigStats?
    private var ticker: AnyCancellable?
    private var work: Task<Void, Never>?
    private let store = "vlessKey"

    init() { load() }

    var hasConfig: Bool { config != nil }
    var country: String? { stats?.country }
    var flag: String? { stats?.flag }
    var publicIp: String? { state.isOn ? stats?.ip : nil }

    func toggle() {
        guard hasConfig else { return }
        switch state {
        case .disconnected: connect()
        case .connected: disconnect()
        default: break
        }
    }

    @discardableResult
    func importKey(_ text: String) -> Bool {
        guard let parsed = VlessParser.parse(text) else { return false }
        config = parsed
        stats = ConfigDeriver.stats(for: parsed)
        UserDefaults.standard.set(parsed.raw, forKey: store)
        return true
    }

    func removeConfig() {
        work?.cancel()
        stopTicker()
        config = nil
        stats = nil
        ping = nil
        elapsed = 0
        state = .disconnected
        UserDefaults.standard.removeObject(forKey: store)
    }

    func connect() {
        work?.cancel()
        state = .connecting
        work = Task { await runConnect() }
    }

    func disconnect() {
        work?.cancel()
        state = .disconnecting
        stopTicker()
        work = Task { await runDisconnect() }
    }

    private func runConnect() async {
        try? await Task.sleep(nanoseconds: 1_100_000_000)
        guard !Task.isCancelled else { return }
        elapsed = 0
        state = .connected
        startTicker()
    }

    private func runDisconnect() async {
        try? await Task.sleep(nanoseconds: 600_000_000)
        guard !Task.isCancelled else { return }
        elapsed = 0
        ping = nil
        state = .disconnected
    }

    private func startTicker() {
        updatePing()
        ticker = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
            .sink { [weak self] _ in self?.tick() }
    }

    private func stopTicker() { ticker?.cancel(); ticker = nil }

    private func tick() {
        elapsed += 1
        updatePing()
    }

    private func updatePing() {
        guard let base = stats?.basePing else { return }
        withAnimation(.easeInOut(duration: 0.35)) {
            ping = max(6, base + Int.random(in: -4...7))
        }
    }

    private func load() {
        guard let raw = UserDefaults.standard.string(forKey: store),
              let parsed = VlessParser.parse(raw) else { return }
        config = parsed
        stats = ConfigDeriver.stats(for: parsed)
    }
}
