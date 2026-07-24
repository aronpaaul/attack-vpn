import Foundation

enum ConnectionState: Equatable {
    case disconnected
    case connecting
    case connected
    case disconnecting

    var title: String {
        switch self {
        case .disconnected: return "Not protected"
        case .connecting: return "Establishing tunnel"
        case .connected: return "Protected"
        case .disconnecting: return "Closing tunnel"
        }
    }

    var isBusy: Bool {
        self == .connecting || self == .disconnecting
    }

    var isOn: Bool {
        self == .connected
    }
}
