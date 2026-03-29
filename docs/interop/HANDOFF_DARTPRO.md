# Handoff Architecture Brief: DartPro UI-Edition

## 📌 Context
The **OperatorGame Flutter Shell** has successfully completed Phase 3.1 & 3.4 (Rust Foundation). The bridge is fully integrated and provides real data mapping from the sovereign Rust core.

## 🚀 Current Bridge Status
- **DTOs**: `SlimeView` is defined and generated in Dart.
- **Provider Hook**: `rosterProvider` (Riverpod) successfully calls `getRoster()`.
- **Data Source**: `getRoster()` loads from `c:\Github\operator_game_flutter\save.json`.
- **Latency**: Benchmarked for <2ms FFI overhead (PoC level).

## 🛠️ Required Dart Implementation (Phase 3 Polish)
- [ ] **Roster Refresh**: Implement a `Refresher` in the UI to poll or reactively update the roster when the bridge data changes.
- [ ] **Cultural Mapping**: Ensure `SlimeColors.getCultureColor()` correctly maps to the `culture` string returned by the bridge.
- [ ] **Glassmorphism Audit**: Verify `BackdropFilter` performance in the `SlimeCard` list.
- [ ] **View Toggle**: Link the `View Detail` button on the card to a detailed view overlay.

## 🔗 Rust Interop Reference
For any business logic extensions (e.g., adding "XP Gains" or "Injuries" to the DTO), refer to:
- **Core Repository**: `C:\Github\OperatorGame`
- **Internal Audit Guide**: `docs/interop/REPOSITORY_GUIDE.md`
- **Bridge Entry Point**: `rust/src/api/simple.rs`

## 🛡️ Sovereign Boundaries
- **DO NOT** implement gameplay logic (leveling, combat, breeding) in Dart.
- **DO** implement presentation logic (animations, themes, gradients, input validation).
- **REQUEST** new DTO fields or bridge functions from **Antigravity** if the UI requires more context from the Rust engine.
