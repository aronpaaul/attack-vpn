import SwiftUI
import Combine

@MainActor
final class VpnController: ObservableObject {
    @Published var state: ConnectionState = .disconnected
    @Published var config: VlessConfig = .sample
    @Published var elapsed: TimeInterval = 0
    @Published var publicIp = "185.189.255.221"
    @Published var pingMs = 24
    @Published var country = "Netherlands"
    @Published var flag = "🇳🇱"

    private var timer: AnyCancellable?
    private var work: Task<Void, Never>?

    func toggle() {
        switch state {
        case .disconnected: connect()
        case .connected: disconnect()
        default: break
        }
    }

    @discardableResult
    func apply(_ text: String) -> Bool {
        guard let parsed = VlessParser.parse(text) else { return false }
        config = parsed
        return true
    }

    func connect() {
        work?.cancel()
        state = .connecting
        work = Task { await runConnect() }
    }

    func disconnect() {
        work?.cancel()
        state = .disconnecting
        stopTimer()
        work = Task { await runDisconnect() }
    }

    private func runConnect() async {
        try? await Task.sleep(nanoseconds: 1_100_000_000)
        guard !Task.isCancelled else { return }
        elapsed = 0
        state = .connected
        startTimer()
    }

    private func runDisconnect() async {
        try? await Task.sleep(nanoseconds: 600_000_000)
        guard !Task.isCancelled else { return }
        elapsed = 0
        state = .disconnected
    }

    private func startTimer() {
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in self?.elapsed += 1 }
    }

    private func stopTimer() {
        timer?.cancel()
        timer = nil
    }
}
