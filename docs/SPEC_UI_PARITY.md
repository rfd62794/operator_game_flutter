# SPEC_UI_PARITY (SDD-050) — War Room Dashboard Specification

This specification documents the reverse-engineered requirements of the Sovereign egui framework to ensure the Flutter implementation achieves 100% functional parity.

## 1. System Layout (Mechanical Constraints)

| Component | Height | Width | Alignment | Feature |
| :--- | :--- | :--- | :--- | :--- |
| **Top Status Bar** | 40dp | Full | Top | Bank ($), Scrap, Stress ProgressBar |
| **Bottom Tab Bar** | 56dp | Full | Bottom | Roster, Ops, Map, Logs |
| **Left Sidebar** | Fill | 120dp | Left | Contextual Sub-tabs (font-size: 15.0) |
| **Content Area** | Fill | ~396dp | Center | Card lists, Detail views |

## 2. Navigation Hierarchy

### Tab 1: Roster (DNA icon)
- **Sub-tab: Collection**: The primary slime list.
- **Sub-tab: Breeding**: The Incubator list and synthesis donors.
- **Sub-tab: Recruit**: Specialized drafts (Elder's Gift, Standard).
- **Sub-tab: Squad**: Finalized deployment squads.

### Tab 2: Missions (Rocket icon)
- **Sub-tab: Active**: Currently running deployments with progress bars.
- **Sub-tab: Quests**: Available mission contracts.

### Tab 3: Map (Globe icon)
- **Sub-tab: Zones**: The Radar node map.
- **Sub-tab: Shop**: The Quartermaster interface.

### Tab 4: Logs (Scroll icon)
- **Sub-tab: Mission History**: Functional combat log (50 entries max).
- **Sub-tab: Culture**: Genomic history.

## 3. Component Specification: SlimeCard (SDD-042 Parity)

The SlimeCard must present 5 distinct logical rows:

1.  **Row 1 (Identity)**: Name (Left), Dominant Culture Label (Center), **STAGE** Toggle (Right).
2.  **Row 2 (Attributes)**: Level, **LifeStage** Label (color-coded), Pattern Label.
3.  **Row 3 (Growth)**: Horizontal XP ProgressBar (4.0 high).
4.  **Row 4 (Vitals)**: STR/AGI/INT stats and Max HP.
5.  **Row 5 (Equipment)**: Equippable Hat button (e.g., "+ EQUIP HAT" or "HAT: Tophat").

## 4. State Colors (Ground Truth)

- **Surface Low**: `#131318` (Panels, Active tab fills)
- **Surface High**: `#25252C` (Separators, Headers)
- **Primary Accent**: `#69FEA5` (Success, Active text)
- **Standard Text**: `#F8F5FD` (Inactive labels)
- **Stress Alert**: `#C83232` (Red progress bars)

> [!IMPORTANT]
> **Performance Constraint**: Bridging must remain synchronous for `getRoster` but asynchronous for `apply_command` to prevent UI hang during persistence.
