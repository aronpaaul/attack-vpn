import Foundation

enum ConnectionState: Equatable {
    case disconnected
    case connecting
    case connected
    case disconnecting

    var isBusy: Bool {
        self == .connecting || self == .disconnecting
    }

    var isOn: Bool {
        self == .connected
    }

    var statusLabel: String {
        switch self {
        case .disconnected: return "Not connected"
        case .connecting: return "Connecting…"
        case .connected: return "Protected"
        case .disconnecting: return "Disconnecting…"
        }
    }
}
