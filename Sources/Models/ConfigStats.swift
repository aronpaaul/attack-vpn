import Foundation

struct ConfigStats: Equatable {
    var country: String
    var flag: String
    var ip: String
    var basePing: Int
}

enum ConfigDeriver {
    private static let places: [(String, String)] = [
        ("Netherlands", "🇳🇱"), ("Germany", "🇩🇪"), ("United States", "🇺🇸"), ("France", "🇫🇷"),
        ("Sweden", "🇸🇪"), ("Japan", "🇯🇵"), ("Singapore", "🇸🇬"), ("United Kingdom", "🇬🇧"),
        ("Finland", "🇫🇮"), ("Switzerland", "🇨🇭"), ("Spain", "🇪🇸"), ("Canada", "🇨🇦")
    ]

    static func stats(for config: VlessConfig) -> ConfigStats {
        let seed = config.address.unicodeScalars.reduce(0) { $0 + Int($1.value) }
        let place = places[seed % places.count]
        let a = seed % 200 + 20
        let b = (seed / 3) % 200 + 10
        let c = (seed / 7) % 90 + 5
        let d = (seed / 11) % 240 + 8
        return ConfigStats(country: place.0, flag: place.1, ip: "\(a).\(b).\(c).\(d)", basePing: seed % 70 + 14)
    }
}
