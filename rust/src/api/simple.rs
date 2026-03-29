use operator::persistence::GameState;

#[flutter_rust_bridge::frb(sync)] // Synchronous mode for simplicity of the demo
pub fn greet(name: String) -> String {
    format!("Hello, {name}! From the Flutter side.")
}

#[flutter_rust_bridge::frb(sync)]
pub fn get_roster_count() -> usize {
    let state = GameState::default(); // Load default state for PoC
    state.slimes.len()
}

#[flutter_rust_bridge::frb(init)]
pub fn init_app() {
    // Default utilities - feel free to customize
    flutter_rust_bridge::setup_default_user_utils();
}
