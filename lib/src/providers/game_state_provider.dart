import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:operator_game_flutter/src/rust/api/simple.rs.dart';
import 'package:operator_game_flutter/src/rust/frb_generated.dart';

final gameStateProvider = FutureProvider<GameStateView>((ref) async {
  // We periodically poll the game state to ensure resource levels stay in sync.
  // In a more complex architecture, we might switch to a Stream for real-time reactivity.
  return getGameState();
});

// Timer-based periodic refresh for resource values
final gameStateTimerProvider = StreamProvider<void>((ref) {
  return Stream.periodic(const Duration(seconds: 1), (_) {});
});
