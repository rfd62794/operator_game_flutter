# OperatorGame: Flutter Shell Constitution

## 1. Core Mission
To provide a high-fidelity, 120fps reactive presentation layer for the sovereign `OperatorGame` Rust engine.

## 2. Architectural Boundaries
- **Sovereign Rust (The Base)**: Located at `C:\Github\OperatorGame`. All game logic, persistence, and state transitions reside here.
- **Flutter Shell (The Presentation)**: Located at `C:\Github\operator_game_flutter`. Responsible for UI, animations, and reactive state orchestration.
- **The Bridge (The FFI)**: `flutter_rust_bridge` (FRB) v2.12.0. No business logic should be written in the bridge; it is strictly a data-mapping layer.

## 3. Role Definitions
- **Sovereign Architect (Antigravity)**: 
  - Implementation of bridge DTOs in Rust.
  - Logic extensions in the Core.
  - Performance and Latency Audits of the FFI layer.
- **UI/UX Architect (DartPro)**:
  - Material 3 Presentation Layer.
  - Riverpod State Providers.
  - Responsive Animations and Glassmorphic Styling.

## 4. Technical Stack
- **State Management**: Riverpod (Reactive)
- **Data Modeling**: Freezed (Immutable)
- **UI Framework**: Flutter (Material 3)
- **Interop**: flutter_rust_bridge v2

## 5. Reference Repositories
- **Rust Core**: `C:\Github\OperatorGame`
- **Flutter Shell**: `C:\Github\operator_game_flutter`
- **Interop Guide**: `docs/interop/REPOSITORY_GUIDE.md`
- **Handoff Brief**: `docs/interop/HANDOFF_DARTPRO.md`
