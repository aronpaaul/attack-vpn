import Foundation

struct VpnServer: Identifiable, Equatable {
    let id: String
    let country: String
    let city: String
    let flag: String
    let pingMs: Int
    let loadPercent: Int

    var host: String {
        id + ".attack.net"
    }
}
