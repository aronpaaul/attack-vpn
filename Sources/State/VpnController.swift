import SwiftUI
import Combine

@MainActor
final class VpnController: ObservableObject {
    @Published var state: ConnectionState = .disconnected
    @Published var server: VpnServer = SampleServers.fastest
    @Published var elapsed: TimeInterval = 0
    @Published var publicIp: String = "5.61.44.19"

    private var timer: AnyCancellable?
    private var work: Task<Void, Never>?

    func toggle() {
        switch state {
        case .disconnected: connect()
        case .connected: disconnect()
        default: break
        }
    }

    func select(_ next: VpnServer) {
        server = next
        if state == .connected {
            publicIp = maskedIp(for: next)
        }
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
        try? await Task.sleep(nanoseconds: 1_400_000_000)
        guard !Task.isCancelled else { return }
        publicIp = maskedIp(for: server)
        elapsed = 0
        state = .connected
        startTimer()
    }

    private func runDisconnect() async {
        try? await Task.sleep(nanoseconds: 700_000_000)
        guard !Task.isCancelled else { return }
        publicIp = "5.61.44.19"
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

    private func maskedIp(for server: VpnServer) -> String {
        let base = server.id.unicodeScalars.reduce(0) { $0 + Int($1.value) }
        return "\(base % 200 + 20).\(base / 2 % 200 + 10).\(base % 90 + 5).\(base % 240 + 8)"
    }
}
