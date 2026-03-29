use operator::persistence::GameState;
use std::path::PathBuf;
use uuid::Uuid;
use chrono::Utc;

// ---------------------------------------------------------------------------
// Bridge DTOs (Data Transfer Objects)
// ---------------------------------------------------------------------------

#[derive(Debug, Clone)]
pub enum UiCommand {
    ToggleStage { id: String },
    EquipHat { slime_id: String, hat_id: String },
    LaunchMission { mission_id: String, operator_ids: Vec<String> },
    RenameSlime { id: String, new_name: String },
    SyncState,
}

#[derive(Debug, Clone)]
pub struct SlimeView {
    pub id: String,
    pub name: String,
    pub culture: String,
    pub level: u32,
    pub cur_xp: u32,
    pub max_xp: u32,
    pub str: u32,
    pub agi: u32,
    pub intel: u32,
    pub hp: f32,
    pub life_stage: String,
    pub is_staged: bool,
    pub state_label: Option<String>,
    pub hat_name: Option<String>,
}

#[derive(Debug, Clone)]
pub struct GameStateView {
    pub bank: i64,
    pub scrap: u32,
    pub stress_level: f32,
}

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

fn get_state() -> GameState {
    let path = std::path::Path::new("save.json");
    operator::persistence::load(path).unwrap_or_default()
}

fn persist_state(state: &GameState) {
    let path = std::path::Path::new("save.json");
    let _ = operator::persistence::save(state, path);
}

// ---------------------------------------------------------------------------
// Synchronous API
// ---------------------------------------------------------------------------

#[flutter_rust_bridge::frb(sync)]
pub fn get_roster() -> Vec<SlimeView> {
    let mut state = get_state();
    
    // Internal Engine Tick: Refresh deployments and recovery
    state.refresh_missions_if_needed(chrono::Utc::now());
    for op in state.slimes.iter_mut() {
        let _ = op.tick_recovery();
    }

    state.slimes.iter().map(|s| {
        let (st, ag, it, _, _, _) = s.total_stats();
        // Note: is_staged will be handled by the Flutter UI state for maximum reactivity,
        // but we expose the field for compatibility.
        SlimeView {
            id: s.genome.id.to_string(),
            name: s.name().to_string(),
            culture: format!("{:?}", s.genome.dominant_culture()),
            level: s.level,
            cur_xp: s.total_xp,
            max_xp: s.xp_to_next(),
            str: st,
            agi: ag,
            int: it,
            hp: s.genome.base_hp,
            life_stage: s.life_stage().to_string().to_uppercase(),
            is_staged: false, 
            state_label: match &s.state {
                crate::models::SlimeState::Deployed(_) => Some("DEPLD".to_string()),
                crate::models::SlimeState::Injured(rem) => Some(format!("INJRD: {}s", rem.num_seconds())),
                _ => None,
            },
            hat_name: s.equipped_hat.map(|h| format!("HAT: {}", h)),
        }
    }).collect()
}

#[flutter_rust_bridge::frb(sync)]
pub fn get_game_state() -> GameStateView {
    let state = get_state();
    GameStateView {
        bank: state.bank,
        scrap: state.inventory.scrap,
        stress_level: state.world_map.startled_level,
    }
}

// ---------------------------------------------------------------------------
// Asynchronous Command Interface
// ---------------------------------------------------------------------------

pub fn apply_ui_command(cmd: UiCommand) {
    let mut state = get_state();

    match cmd {
        UiCommand::EquipHat { slime_id, hat_id } => {
            if let Ok(uid) = uuid::Uuid::parse_str(&slime_id) {
                if let Ok(hid) = uuid::Uuid::parse_str(&hat_id) {
                    if let Some(op) = state.slimes.iter_mut().find(|s| s.genome.id == uid) {
                        op.equipped_hat = Some(hid);
                    }
                }
            }
        }
        UiCommand::SyncState => {
            // Force save and refresh
        }
        _ => {
            // Remaining commands (LaunchMission, Rename) implemented in Phase 5.2
        }
    }

    persist_state(&state);
}

#[flutter_rust_bridge::frb(init)]
pub fn init_app() {
    flutter_rust_bridge::setup_default_user_utils();
}
