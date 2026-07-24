import Foundation

enum SampleServers {
    static let all: [VpnServer] = [
        VpnServer(id: "nl-ams", country: "Netherlands", city: "Amsterdam", flag: "🇳🇱", pingMs: 18, loadPercent: 24),
        VpnServer(id: "de-fra", country: "Germany", city: "Frankfurt", flag: "🇩🇪", pingMs: 26, loadPercent: 41),
        VpnServer(id: "se-sto", country: "Sweden", city: "Stockholm", flag: "🇸🇪", pingMs: 22, loadPercent: 19),
        VpnServer(id: "fr-par", country: "France", city: "Paris", flag: "🇫🇷", pingMs: 31, loadPercent: 47),
        VpnServer(id: "us-nyc", country: "United States", city: "New York", flag: "🇺🇸", pingMs: 92, loadPercent: 58),
        VpnServer(id: "ae-dxb", country: "UAE", city: "Dubai", flag: "🇦🇪", pingMs: 78, loadPercent: 52),
        VpnServer(id: "sg-sin", country: "Singapore", city: "Singapore", flag: "🇸🇬", pingMs: 121, loadPercent: 29),
        VpnServer(id: "jp-tyo", country: "Japan", city: "Tokyo", flag: "🇯🇵", pingMs: 140, loadPercent: 33)
    ]

    static let fastest = all[0]
}
