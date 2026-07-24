import Foundation

struct VlessConfig: Equatable {
    var name: String
    var uuid: String
    var address: String
    var port: Int
    var security: String
    var sni: String
    var raw: String

    var securityTag: String {
        security.isEmpty ? "TCP" : security.uppercased()
    }

    var maskedRaw: String {
        raw.count > 44 ? String(raw.prefix(44)) + "…" : raw
    }

    static let sample = VlessConfig(
        name: "Amsterdam Core",
        uuid: "d1f4c0e2",
        address: "nl-ams.attack.net",
        port: 443,
        security: "reality",
        sni: "www.microsoft.com",
        raw: "vless://d1f4c0e2@nl-ams.attack.net:443?security=reality#Amsterdam"
    )
}
