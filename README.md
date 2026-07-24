# Attack VPN

Native iOS VPN client UI built with SwiftUI. Universal — iPhone and iPad.
Design demo: living core orb, hold-to-connect with escalating CoreHaptics, animated aurora background, server picker.

> This is a UI/interaction showcase, not a real tunnel — no traffic is routed.

## Build the .ipa

Xcode required. The project is generated with XcodeGen.

```bash
brew install xcodegen
xcodegen generate
bash Scripts/build-ipa.sh
```

Output: `build/AttackVPN.ipa` (unsigned).

## No Xcode? Use CI

Every push builds the unsigned `.ipa` on GitHub Actions. Tagged pushes attach it to a Release:

```bash
git tag v0.1.0 && git push origin v0.1.0
```

Grab `AttackVPN.ipa` from the release, sign it, install.

## Stack

SwiftUI, Canvas + TimelineView animations, CoreHaptics, async/await state machine. iOS 17+.
