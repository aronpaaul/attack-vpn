import Foundation

enum VlessParser {
    static func parse(_ text: String) -> VlessConfig? {
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard trimmed.lowercased().hasPrefix("vless://") else { return nil }
        guard let comps = URLComponents(string: trimmed),
              let uuid = comps.user,
              let host = comps.host,
              let port = comps.port else { return nil }
        let query = comps.queryItems ?? []
        let security = value(query, "security") ?? "tcp"
        let sni = value(query, "sni") ?? value(query, "host") ?? host
        let name = comps.fragment?.removingPercentEncoding ?? host
        return VlessConfig(name: name, uuid: uuid, address: host, port: port,
                           security: security, sni: sni, raw: trimmed)
    }

    private static func value(_ items: [URLQueryItem], _ key: String) -> String? {
        items.first { $0.name == key }?.value
    }
}
