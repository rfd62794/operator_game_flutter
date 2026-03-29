import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:operator_game_flutter/src/rust/api/simple.dart';

enum MainTab { roster, ops, map, logs }

final activeMainTabProvider = StateProvider<MainTab>((ref) => MainTab.roster);

final rosterProvider = StreamProvider<List<SlimeView>>((ref) async* {
  while (true) {
    yield getRoster();
    await Future.delayed(const Duration(seconds: 1));
  }
});
