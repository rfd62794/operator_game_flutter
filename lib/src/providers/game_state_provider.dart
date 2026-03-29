import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:operator_game_flutter/src/rust/api/simple.dart';
import 'package:operator_game_flutter/src/rust/frb_generated.dart';

final gameStateProvider = StreamProvider<GameStateView>((ref) async* {
  while (true) {
    yield getGameState();
    await Future.delayed(const Duration(seconds: 2));
  }
});
