import SwiftUI

struct WhiteButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 16, weight: .bold))
            .foregroundStyle(Color(red: 0.07, green: 0.07, blue: 0.08))
            .frame(maxWidth: .infinity)
            .padding(.vertical, 18)
            .background(configuration.isPressed ? Palette.whitePress : Palette.white,
                        in: RoundedRectangle(cornerRadius: 18, style: .continuous))
    }
}
