import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:operator_game_flutter/src/providers/diagnostic_provider.dart';
import 'package:operator_game_flutter/src/providers/game_state_provider.dart';
import 'package:operator_game_flutter/src/providers/nav_provider.dart';
import 'package:operator_game_flutter/src/providers/roster_provider.dart';
import 'package:operator_game_flutter/src/theme/app_theme.dart';
import 'package:operator_game_flutter/src/widgets/slime_card.dart';

void main() {
  runApp(
    const ProviderScope(
      child: OperatorApp(),
    ),
  );
}

class OperatorApp extends StatelessWidget {
  const OperatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OPERATOR: War Room',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const WarRoomLayout(),
    );
  }
}

class WarRoomLayout extends ConsumerWidget {
  const WarRoomLayout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              const _TopStatusBar(),
              Expanded(
                child: Row(
                  children: [
                    const _Sidebar(),
                    const VerticalDivider(width: 1, color: AppTheme.surfaceHigh),
                    Expanded(child: _MainContent()),
                  ],
                ),
              ),
              const _BottomNavBar(),
            ],
          ),
          const Positioned(
            bottom: 60, // Above bottom bar
            left: 0,
            right: 0,
            child: _DiagnosticOverlay(),
          ),
          const _AAROverlay(),
        ],
      ),
    );
  }
}

class _AAROverlay extends ConsumerWidget {
  const _AAROverlay();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Placeholder for Phase 5.6 AAR integration
    return const SizedBox.shrink();
  }
}

class _TopStatusBar extends ConsumerWidget {
  const _TopStatusBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameStateAsync = ref.watch(gameStateProvider);
    // Trigger periodic refresh
    ref.listen(gameStateTimerProvider, (_, __) => ref.invalidate(gameStateProvider));

    return Container(
      height: 40,
      color: AppTheme.surfaceLow,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: gameStateAsync.when(
        data: (state) => Row(
          children: [
            const Text('OPERATOR', style: TextStyle(fontWeight: FontWeight.bold)),
            const VerticalDivider(indent: 10, endIndent: 10, color: Colors.white24),
            Text('Bank: \$${state.bank}'),
            const VerticalDivider(indent: 10, endIndent: 10, color: Colors.white24),
            Text('Scrap: ${state.scrap}'),
            const Spacer(),
            if (state.stressLevel > 0.01)
              SizedBox(
                width: 100,
                child: LinearProgressIndicator(
                  value: (state.stressLevel / 10.0).clamp(0.0, 1.0),
                  backgroundColor: Colors.white10,
                  valueColor: const AlwaysStoppedAnimation(AppTheme.stressAlert),
                ),
              ),
          ],
        ),
        loading: () => const Center(child: LinearProgressIndicator()),
        error: (_, __) => const Text('SYNC ERROR', style: TextStyle(color: AppTheme.stressAlert)),
      ),
    );
  }
}

class _Sidebar extends ConsumerWidget {
  const _Sidebar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mainTab = ref.watch(activeMainTabProvider);
    
    return Container(
      width: 120,
      color: AppTheme.surfaceLow,
      child: Column(
        children: [
          const SizedBox(height: 16),
          if (mainTab == MainTab.roster) ...[
            _SubTabItem(label: '🧬 COLLECTION', activated: ref.watch(rosterSubTabProvider) == RosterSubTab.collection, onTap: () => ref.read(rosterSubTabProvider.notifier).state = RosterSubTab.collection),
            _SubTabItem(label: '🧪 BREEDING', activated: ref.watch(rosterSubTabProvider) == RosterSubTab.breeding, onTap: () => ref.read(rosterSubTabProvider.notifier).state = RosterSubTab.breeding),
            _SubTabItem(label: '🎖️ RECRUIT', activated: ref.watch(rosterSubTabProvider) == RosterSubTab.recruit, onTap: () => ref.read(rosterSubTabProvider.notifier).state = RosterSubTab.recruit),
            _SubTabItem(label: '🛡️ SQUAD', activated: ref.watch(rosterSubTabProvider) == RosterSubTab.squad, onTap: () => ref.read(rosterSubTabProvider.notifier).state = RosterSubTab.squad),
          ] else if (mainTab == MainTab.ops) ...[
            _SubTabItem(label: '🚀 ACTIVE', activated: ref.watch(opsSubTabProvider) == OpsSubTab.active, onTap: () => ref.read(opsSubTabProvider.notifier).state = OpsSubTab.active),
            _SubTabItem(label: '📝 QUESTS', activated: ref.watch(opsSubTabProvider) == OpsSubTab.quests, onTap: () => ref.read(opsSubTabProvider.notifier).state = OpsSubTab.quests),
          ] else ...[
             const Center(child: Text('Coming Soon', style: TextStyle(color: Colors.white24, fontSize: 10))),
          ],
        ],
      ),
    );
  }
}

class _SubTabItem extends StatelessWidget {
  final String label;
  final bool activated;
  final VoidCallback onTap;

  const _SubTabItem({required this.label, required this.activated, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        width: double.infinity,
        color: activated ? AppTheme.surfaceHigh : Colors.transparent,
        child: Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: activated ? FontWeight.bold : FontWeight.normal,
            color: activated ? AppTheme.primaryAccent : Colors.white60,
          ),
        ),
      ),
    );
  }
}

class _MainContent extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mainTab = ref.watch(activeMainTabProvider);
    final rosterSubTab = ref.watch(rosterSubTabProvider);
    final opsSubTab = ref.watch(opsSubTabProvider);
    final mapSubTab = ref.watch(mapSubTabProvider);
    final logsSubTab = ref.watch(logsSubTabProvider);

    switch (mainTab) {
      case MainTab.roster:
        switch (rosterSubTab) {
          case RosterSubTab.collection: return const RosterView();
          default: return _PlaceholderView(label: 'ROSTER / ${rosterSubTab.name.toUpperCase()}');
        }
      case MainTab.ops:
        switch (opsSubTab) {
          case OpsSubTab.quests: return const QuestBoardView();
          case OpsSubTab.active: return const ActiveOpsView();
        }
      case MainTab.map:
        switch (mapSubTab) {
          case MapSubTab.zones: return const RadarView();
          case MapSubTab.shop: return const ShopView();
        }
      case MainTab.logs:
        switch (logsSubTab) {
          case LogsSubTab.missions: return const CombatLogView();
          default: return _PlaceholderView(label: 'LOGS / ${logsSubTab.name.toUpperCase()}');
        }
    }
  }
}

class _PlaceholderView extends StatelessWidget {
  final String label;
  const _PlaceholderView({required this.label});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.construction, color: Colors.white10, size: 48),
          const SizedBox(height: 16),
          Text(label, style: const TextStyle(color: Colors.white24, letterSpacing: 1.5)),
          const Text('PHASE 5.5 INTEGRATION PENDING', style: TextStyle(color: Colors.white10, fontSize: 8)),
        ],
      ),
    );
  }
}

class RosterView extends ConsumerWidget {
  const RosterView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rosterAsync = ref.watch(rosterProvider);

    return rosterAsync.when(
      data: (roster) {
        if (roster.isEmpty) return const _EmptyRosterView();
        return RefreshIndicator(
          onRefresh: () => ref.read(rosterProvider.notifier).refresh(),
          child: ListView.separated(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            itemCount: roster.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) => SlimeCard(slime: roster[index]),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, _) => _ErrorView(error: err.toString()),
    );
  }
}

class _BottomNavBar extends ConsumerWidget {
  const _BottomNavBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeTab = ref.watch(activeMainTabProvider);

    return Container(
      height: 56,
      color: AppTheme.surfaceLow,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _TabItem(icon: Icons.dna, label: 'Roster', active: activeTab == MainTab.roster, onTap: () => ref.read(activeMainTabProvider.notifier).state = MainTab.roster),
          _TabItem(icon: Icons.rocket_launch, label: 'Ops', active: activeTab == MainTab.ops, onTap: () => ref.read(activeMainTabProvider.notifier).state = MainTab.ops),
          _TabItem(icon: Icons.public, label: 'Map', active: activeTab == MainTab.map, onTap: () => ref.read(activeMainTabProvider.notifier).state = MainTab.map),
          _TabItem(icon: Icons.history_edu, label: 'Logs', active: activeTab == MainTab.logs, onTap: () => ref.read(activeMainTabProvider.notifier).state = MainTab.logs),
        ],
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _TabItem({required this.icon, required this.label, required this.active, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: active ? AppTheme.primaryAccent : Colors.white38, size: 24),
          const SizedBox(height: 2),
          Text(label, style: TextStyle(color: active ? AppTheme.primaryAccent : Colors.white38, fontSize: 10)),
        ],
      ),
    );
  }
}

class _DiagnosticOverlay extends ConsumerWidget {
  const _DiagnosticOverlay();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final latencyMicros = ref.watch(bridgeLatencyProvider);
    final latencyMs = latencyMicros / 1000.0;
    final color = latencyMs < 2.0 ? Colors.greenAccent : (latencyMs < 5.0 ? Colors.orangeAccent : Colors.redAccent);

    return Container(
      color: Colors.black.withOpacity(0.8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.speed, size: 12, color: Colors.white38),
          const SizedBox(width: 8),
          Text('BRIDGE ROUND TRIP: ${latencyMs.toStringAsFixed(2)}ms', style: const TextStyle(fontSize: 9, fontFamily: 'monospace', color: Colors.white70)),
          const SizedBox(width: 16),
          Text(latencyMs < 8.33 ? '120FPS: OK' : '120FPS: FAIL', style: TextStyle(color: latencyMs < 8.33 ? AppTheme.primaryAccent : AppTheme.stressAlert, fontSize: 9, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class _EmptyRosterView extends StatelessWidget {
  const _EmptyRosterView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inventory_2_outlined, size: 48, color: Colors.white10),
          SizedBox(height: 16),
          Text('BIO-MANIFEST EMPTY', style: TextStyle(color: Colors.white24, letterSpacing: 1)),
        ],
      ),
    );
  }
}

class QuestBoardView extends StatelessWidget {
  const QuestBoardView({super.key});

  @override
  Widget build(BuildContext context) {
    return const _PlaceholderView(label: 'QUEST BOARD (SDD-038)');
  }
}

class ActiveOpsView extends StatelessWidget {
  const ActiveOpsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const _PlaceholderView(label: 'ACTIVE OPERATIONS (SDD-038)');
  }
}

class RadarView extends StatelessWidget {
  const RadarView({super.key});

  @override
  Widget build(BuildContext context) {
    return const _PlaceholderView(label: 'RADAR ZONES');
  }
}

class ShopView extends StatelessWidget {
  const ShopView({super.key});

  @override
  Widget build(BuildContext context) {
    return const _PlaceholderView(label: 'QUARTERMASTER');
  }
}

class CombatLogView extends StatelessWidget {
  const CombatLogView({super.key});

  @override
  Widget build(BuildContext context) {
    return const _PlaceholderView(label: 'MISSION HISTORY');
  }
}

class _ErrorView extends ConsumerWidget {
  final String error;
  const _ErrorView({required this.error});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Icon(Icons.sync_problem, color: AppTheme.stressAlert, size: 48),
            const SizedBox(height: 16),
            Text('SYNC ERROR\n$error', style: const TextStyle(color: AppTheme.stressAlert), textAlign: TextAlign.center),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => ref.read(rosterProvider.notifier).refresh(),
              child: const Text('RETRY SYNC'),
            ),
          ],
        ),
      ),
    );
  }
}
