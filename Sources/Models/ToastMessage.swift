import SwiftUI

enum ToastKind: Equatable {
    case success
    case error
    case neutral

    var accent: Color {
        switch self {
        case .success: return Color(red: 0.22, green: 0.85, blue: 0.62)
        case .error: return Color(red: 1, green: 0.42, blue: 0.45)
        case .neutral: return Palette.text
        }
    }

    var icon: String {
        switch self {
        case .success: return "circle-check"
        case .error: return "circle-alert"
        case .neutral: return "copy"
        }
    }
}

struct ToastMessage: Equatable, Identifiable {
    let id = UUID()
    let text: String
    let kind: ToastKind
}
