import SwiftUI

struct QRSheet: View {
    let text: String
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                if let image = QRCode.image(from: text) {
                    Image(uiImage: image)
                        .interpolation(.none)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 260)
                        .padding(20)
                        .background(Color.white, in: RoundedRectangle(cornerRadius: 24, style: .continuous))
                } else {
                    Text("Cannot render QR").foregroundStyle(Palette.muted)
                }
                Text(text)
                    .font(.system(size: 12, design: .monospaced))
                    .foregroundStyle(Palette.muted)
                    .lineLimit(2)
                    .truncationMode(.middle)
                    .padding(.horizontal, 30)
                Spacer()
            }
            .padding(.top, 30)
            .frame(maxWidth: .infinity)
            .background(Palette.bg)
            .navigationTitle("Key QR")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { ToolbarItem(placement: .confirmationAction) { Button("Done") { dismiss() } } }
        }
    }
}
