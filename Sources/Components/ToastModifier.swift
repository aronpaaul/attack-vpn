import SwiftUI

extension View {
    func toast(_ message: Binding<ToastMessage?>) -> some View {
        overlay(alignment: .bottom) {
            if let current = message.wrappedValue {
                ToastView(message: current)
                    .padding(.bottom, 44)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                    .task(id: current.id) {
                        try? await Task.sleep(nanoseconds: 2_000_000_000)
                        withAnimation(.easeInOut(duration: 0.25)) { message.wrappedValue = nil }
                    }
            }
        }
        .animation(.easeInOut(duration: 0.25), value: message.wrappedValue)
    }
}
