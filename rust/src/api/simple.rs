use operator::persistence::GameState;

#[derive(Debug, Clone)]
pub struct SlimeView {
    pub id: String,
    pub name: String,
    pub culture: String,
    pub level: u8,
    pub stage: String,
    pub hp: u32,
    pub max_hp: u32,
    pub xp_progress: f32,
    pub staged: bool,
}

#[flutter_rust_bridge::frb(sync)] // Synchronous mode for simplicity of the demo
pub fn greet(name: String) -> String {
    format!("Hello, {name}! From the Flutter side.")
}

#[flutter_rust_bridge::frb(sync)]
pub fn get_roster_count() -> usize {
    let state = GameState::default(); // Load default state for PoC
    state.slimes.len()
}

#[flutter_rust_bridge::frb(sync)]
pub fn get_roster() -> Vec<SlimeView> {
    // In a real app, we would load the state from disk here.
    // For this implementation step, we use the default state to verify the DTO mapping.
    let state = GameState::default(); 
    state.slimes.iter().map(|op| {
        SlimeView {
            id: op.id().to_string(),
            name: op.name().to_string(),
            culture: op.genome.dominant_culture().to_string(),
            level: op.level,
            stage: op.life_stage().to_string(),
            hp: op.genome.base_hp as u32,
            max_hp: op.genome.base_hp as u32,
            xp_progress: (op.total_xp % 100) as f32 / 100.0,
            staged: false, // Wire to real deployment state in next iteration
        }
    }).collect()
}

#[flutter_rust_bridge::frb(init)]
pub fn init_app() {
    // Default utilities - feel free to customize
    flutter_rust_bridge::setup_default_user_utils();
}
