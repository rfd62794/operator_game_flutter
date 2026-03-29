import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:operator_game_flutter/src/providers/roster_provider.dart';
import 'package:operator_game_flutter/src/providers/nav_provider.dart';
import 'package:operator_game_flutter/src/providers/game_state_provider.dart';
import 'package:operator_game_flutter/src/rust/frb_generated.dart';
import 'package:operator_game_flutter/src/providers/diagnostic_provider.dart';
import 'package:operator_game_flutter/src/theme/app_theme.dart';
import 'package:operator_game_flutter/src/widgets/slime_card.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await RustLib.init();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OperatorGame: War Room',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const WarRoomDashboard(),
    );
  }
}

class WarRoomDashboard extends ConsumerWidget {
  const WarRoomDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeTab = ref.watch(activeMainTabProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F14),
      body: SafeArea(
        child: Column(
          children: [
            const _TopStatusBar(),
            Expanded(
              child: Row(
                children: [
                  const _SideBar(),
                  VerticalDivider(width: 1, color: Colors.white.withOpacity(0.05)),
                  Expanded(
                    child: Stack(
                      children: [
                        _TabContentSwitcher(activeTab: activeTab),
                        const Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: _DiagnosticOverlay(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const _BottomNavBar(),
          ],
        ),
      ),
    );
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
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF131318),
        border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.05))),
      ),
      child: Row(
        children: [
          const Text(
            'OPERATOR',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
              fontSize: 14,
              color: Color(0xFF69FEA5),
            ),
          ),
          const VerticalDivider(indent: 10, endIndent: 10, width: 32),
          gameStateAsync.when(
            data: (gs) => Row(
              children: [
                _StatusItem(label: 'Bank', value: '\$${gs.bank}'),
                const SizedBox(width: 16),
                _StatusItem(label: 'Scrap', value: '${gs.scrap}'),
                const SizedBox(width: 16),
                _StressIndicator(value: gs.stressLevel),
              ],
            ),
            loading: () => const Text('SYNCING...', style: TextStyle(fontSize: 10, color: Colors.white24)),
            error: (_, __) => const Text('OFFLINE', style: TextStyle(fontSize: 10, color: Colors.redAccent)),
          ),
        ],
      ),
    );
  }
}

class _StatusItem extends StatelessWidget {
  final String label;
  final String value;
  const _StatusItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('$label: ', style: const TextStyle(fontSize: 12, color: Colors.white38)),
        Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white70)),
      ],
    );
  }
}

class _StressIndicator extends StatelessWidget {
  final double value;
  const _StressIndicator({required this.value});

  @override
  Widget build(BuildContext context) {
    final pct = (value / 10.0).clamp(0.0, 1.0);
    return Row(
      children: [
        const Text('Stress: ', style: TextStyle(fontSize: 12, color: Colors.white38)),
        SizedBox(
          width: 80,
          height: 4,
          child: LinearProgressIndicator(
            value: pct,
            backgroundColor: Colors.white.withOpacity(0.05),
            valueColor: AlwaysStoppedAnimation(pct > 0.7 ? Colors.redAccent : const Color(0xFF69FEA5)),
          ),
        ),
      ],
    );
  }
}

class _SideBar extends ConsumerWidget {
  const _SideBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeTab = ref.watch(activeMainTabProvider);
    
    return Container(
      width: 120,
      color: const Color(0xFF131318),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              activeTab.name.toUpperCase(),
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Color(0xFF69FEA5),
                letterSpacing: 1.2,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Divider(color: Colors.white.withOpacity(0.05), indent: 12, endIndent: 12),
          const Expanded(child: _SubTabList()),
        ],
      ),
    );
  }
}

class _SubTabList extends ConsumerWidget {
  const _SubTabList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeTab = ref.watch(activeMainTabProvider);
    
    switch (activeTab) {
      case MainTab.roster:
        return Column(
          children: [
            _SubTabButton(
              label: 'Collection', 
              isActive: ref.watch(rosterSubTabProvider) == RosterSubTab.collection,
              onTap: () => ref.read(rosterSubTabProvider.notifier).state = RosterSubTab.collection,
            ),
            _SubTabButton(
              label: 'Breeding', 
              isActive: ref.watch(rosterSubTabProvider) == RosterSubTab.breeding,
              onTap: () => ref.read(rosterSubTabProvider.notifier).state = RosterSubTab.breeding,
            ),
            _SubTabButton(
              label: 'Recruit', 
              isActive: ref.watch(rosterSubTabProvider) == RosterSubTab.recruit,
              onTap: () => ref.read(rosterSubTabProvider.notifier).state = RosterSubTab.recruit,
            ),
          ],
        );
      default:
        return const Center(child: Text('Coming Soon', style: TextStyle(fontSize: 10, color: Colors.white10)));
    }
  }
}

class _SubTabButton extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;
  
  const _SubTabButton({required this.label, required this.isActive, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        color: isActive ? Colors.white.withOpacity(0.03) : Colors.transparent,
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: isActive ? const Color(0xFF69FEA5) : Colors.white38,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
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
      decoration: BoxDecoration(
        color: const Color(0xFF131318),
        border: Border(top: BorderSide(color: Colors.white.withOpacity(0.05))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _BottomTabItem(
            icon: Icons.dna, 
            label: 'ROSTER', 
            isActive: activeTab == MainTab.roster,
            onTap: () => ref.read(activeMainTabProvider.notifier).state = MainTab.roster,
          ),
          _BottomTabItem(
            icon: Icons.rocket_launch, 
            label: 'OPS', 
            isActive: activeTab == MainTab.ops,
            onTap: () => ref.read(activeMainTabProvider.notifier).state = MainTab.ops,
          ),
          _BottomTabItem(
            icon: Icons.public, 
            label: 'MAP', 
            isActive: activeTab == MainTab.map,
            onTap: () => ref.read(activeMainTabProvider.notifier).state = MainTab.map,
          ),
          _BottomTabItem(
            icon: Icons.history_edu, 
            label: 'LOGS', 
            isActive: activeTab == MainTab.logs,
            onTap: () => ref.read(activeMainTabProvider.notifier).state = MainTab.logs,
          ),
        ],
      ),
    );
  }
}

class _BottomTabItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _BottomTabItem({required this.icon, required this.label, required this.isActive, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 20, color: isActive ? const Color(0xFF69FEA5) : Colors.white24),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: isActive ? const Color(0xFF69FEA5) : Colors.white24,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

class _TabContentSwitcher extends ConsumerWidget {
  final MainTab activeTab;
  const _TabContentSwitcher({required this.activeTab});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    switch (activeTab) {
      case MainTab.roster:
        return const _RosterTabPage();
      default:
        return Center(
          child: Text(
            '${activeTab.name.toUpperCase()} SYSTEM OFFLINE',
            style: const TextStyle(color: Colors.white10, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        );
    }
  }
}

class _RosterTabPage extends ConsumerWidget {
  const _RosterTabPage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rosterSubTab = ref.watch(rosterSubTabProvider);

    switch (rosterSubTab) {
      case RosterSubTab.collection:
        return const _CollectionGridView();
      default:
        return Center(
          child: Text(
            '${rosterSubTab.name.toUpperCase()} UNAVAILABLE',
            style: const TextStyle(color: Colors.white10),
          ),
        );
    }
  }
}

class _CollectionGridView extends ConsumerWidget {
  const _CollectionGridView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rosterAsync = ref.watch(rosterProvider);

    return rosterAsync.when(
      data: (roster) => ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: roster.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) => SlimeCard(slime: roster[index]),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, __) => Center(child: Text('Sync Error: $e', style: const TextStyle(color: Colors.redAccent))),
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
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.speed, size: 14, color: Colors.white38),
          const SizedBox(width: 8),
          Text(
            'BRIDGE: ${latencyMs.toStringAsFixed(2)}ms',
            style: const TextStyle(color: Colors.white38, fontSize: 10, fontFamily: 'monospace'),
          ),
          const SizedBox(width: 16),
          Text(
            latencyMs < 8.33 ? '120FPS: OK' : '120FPS: LAG',
            style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
