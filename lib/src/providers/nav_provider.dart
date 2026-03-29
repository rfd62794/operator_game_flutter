import 'package:flutter_riverpod/flutter_riverpod.dart';

enum MainTab { roster, ops, map, logs }

enum RosterSubTab { collection, breeding, recruit, squad }

enum OpsSubTab { active, quests }

enum MapSubTab { zones, shop }

enum LogsSubTab { missions, culture }

final activeMainTabProvider = StateProvider<MainTab>((ref) => MainTab.roster);

final rosterSubTabProvider = StateProvider<RosterSubTab>((ref) => RosterSubTab.collection);

final opsSubTabProvider = StateProvider<OpsSubTab>((ref) => OpsSubTab.active);

final mapSubTabProvider = StateProvider<MapSubTab>((ref) => MapSubTab.zones);

final logsSubTabProvider = StateProvider<LogsSubTab>((ref) => LogsSubTab.missions);
