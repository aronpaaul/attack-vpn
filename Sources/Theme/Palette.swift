import SwiftUI

enum Palette {
    static let background = Color(red: 0.03, green: 0.04, blue: 0.06)
    static let surface = Color(red: 0.09, green: 0.10, blue: 0.14)
    static let textPrimary = Color.white
    static let textMuted = Color.white.opacity(0.55)

    static let danger = Color(red: 1.0, green: 0.32, blue: 0.36)
    static let idle = Color(red: 0.45, green: 0.50, blue: 0.62)
    static let live = Color(red: 0.16, green: 0.95, blue: 0.66)
    static let warm = Color(red: 1.0, green: 0.72, blue: 0.24)

    static func accent(for state: ConnectionState) -> Color {
        switch state {
        case .disconnected: return danger
        case .connecting: return warm
        case .connected: return live
        case .disconnecting: return idle
        }
    }
}
