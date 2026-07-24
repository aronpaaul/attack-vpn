import SwiftUI

struct Icon: View {
    let name: String
    var size: CGFloat = 22
    var color: Color = Palette.text

    init(_ name: String, size: CGFloat = 22, color: Color = Palette.text) {
        self.name = name
        self.size = size
        self.color = color
    }

    var body: some View {
        Image(name)
            .renderingMode(.template)
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size)
            .foregroundStyle(color)
    }
}
