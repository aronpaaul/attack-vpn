import SwiftUI

struct PingBarsView: View {
    let pingMs: Int

    private var level: Int {
        switch pingMs {
        case ..<40: return 4
        case ..<80: return 3
        case ..<120: return 2
        default: return 1
        }
    }

    private var color: Color {
        switch level {
        case 4: return Palette.live
        case 3: return Color(red: 0.6, green: 0.9, blue: 0.4)
        case 2: return Palette.warm
        default: return Palette.danger
        }
    }

    var body: some View {
        HStack(alignment: .bottom, spacing: 3) {
            ForEach(0..<4) { i in
                RoundedRectangle(cornerRadius: 1.5)
                    .fill(i < level ? color : Palette.textMuted.opacity(0.25))
                    .frame(width: 4, height: 6 + CGFloat(i) * 4)
            }
        }
    }
}
