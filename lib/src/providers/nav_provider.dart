import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:operator_game_flutter/src/rust/api/simple.dart';

enum MainTab { roster, ops, map, logs }

// Sub-Tabs (Parity with Sidebar.rs)
enum RosterSubTab { active, staged, reserves }
enum OpsSubTab { active, available, history }
enum MapSubTab { sectors, intel, warp }
enum LogsSubTab { combat, market, system }

final activeMainTabProvider = StateProvider<MainTab>((ref) => MainTab.roster);

// Sub-Tab Providers
final rosterSubTabProvider = StateProvider<RosterSubTab>((ref) => RosterSubTab.active);
final opsSubTabProvider = StateProvider<OpsSubTab>((ref) => OpsSubTab.available);
final mapSubTabProvider = StateProvider<MapSubTab>((ref) => MapSubTab.sectors);
final logsSubTabProvider = StateProvider<LogsSubTab>((ref) => LogsSubTab.combat);

final rosterProvider = StreamProvider<List<SlimeView>>((ref) async* {
  while (true) {
    yield getRoster();
    await Future.delayed(const Duration(seconds: 1));
  }
});
