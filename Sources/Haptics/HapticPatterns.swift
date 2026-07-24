import CoreHaptics

enum HapticPatterns {
    private static func transient(_ intensity: Float, _ sharpness: Float, at time: Double) -> CHHapticEvent {
        CHHapticEvent(eventType: .hapticTransient, parameters: [
            CHHapticEventParameter(parameterID: .hapticIntensity, value: intensity),
            CHHapticEventParameter(parameterID: .hapticSharpness, value: sharpness)
        ], relativeTime: time)
    }

    static func tick() -> CHHapticPattern? {
        try? CHHapticPattern(events: [transient(0.6, 0.7, at: 0)], parameters: [])
    }

    static func connectRamp() -> CHHapticPattern? {
        let steps = 10
        let events = (0..<steps).map { i -> CHHapticEvent in
            let t = Double(i) / Double(steps)
            return transient(Float(0.25 + t * 0.65), Float(0.3 + t * 0.5), at: t * 1.1)
        }
        return try? CHHapticPattern(events: events, parameters: [])
    }

    static func connected() -> CHHapticPattern? {
        let body = CHHapticEvent(eventType: .hapticContinuous, parameters: [
            CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.9),
            CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.4)
        ], relativeTime: 0, duration: 0.28)
        return try? CHHapticPattern(events: [body, transient(1.0, 0.9, at: 0.28)], parameters: [])
    }

    static func disconnected() -> CHHapticPattern? {
        let body = CHHapticEvent(eventType: .hapticContinuous, parameters: [
            CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.7),
            CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.2)
        ], relativeTime: 0, duration: 0.4)
        return try? CHHapticPattern(events: [body], parameters: [])
    }
}
