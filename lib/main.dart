import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:operator_game_flutter/src/providers/game_state_provider.dart';
import 'package:operator_game_flutter/src/providers/nav_provider.dart';
import 'package:operator_game_flutter/src/rust/api/simple.dart';
import 'package:operator_game_flutter/src/rust/frb_generated.dart';
import 'package:operator_game_flutter/src/theme/app_theme.dart';
import 'package:operator_game_flutter/src/widgets/slime_card.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await RustLib.init();
  runApp(const ProviderScope(child: OperatorApp()));
}

class OperatorApp extends StatelessWidget {
  const OperatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OperatorGame',
      theme: AppTheme.darkTheme,
      home: const WarRoomDashboard(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class WarRoomDashboard extends ConsumerWidget {
  const WarRoomDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeTab = ref.watch(activeMainTabProvider);

    return Scaffold(
      body: Column(
        children: [
          // 40dp Top Status Bar
          const _TopStatusBar(),
          
          Expanded(
            child: Row(
              children: [
                // 120dp Sub-tab Sidebar
                const _Sidebar(),
                
                // Main Content Area
                Expanded(
                  child: _buildMainContent(activeTab),
                ),
              ],
            ),
          ),
          
          // 56dp Bottom Navigation
          const _BottomNavBar(),
        ],
      ),
    );
  }

  Widget _buildMainContent(MainTab tab) {
    switch (tab) {
      case MainTab.roster:
        return const _RosterView();
      case MainTab.ops:
        return const Center(child: Text('OPS CENTER - UNAVAILABLE', style: TextStyle(color: Colors.white24)));
      case MainTab.map:
        return const Center(child: Text('STRATEGIC MAP - UNAVAILABLE', style: TextStyle(color: Colors.white24)));
      case MainTab.logs:
        return const Center(child: Text('MISSION LOGS - UNAVAILABLE', style: TextStyle(color: Colors.white24)));
    }
  }
}

class _TopStatusBar extends ConsumerWidget {
  const _TopStatusBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameStateProvider);

    return Container(
      height: 40,
      color: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _TelemetryItem(label: 'BANK', value: '\$${gameState.value?.bank ?? 0}', color: Colors.greenAccent),
          _TelemetryItem(label: 'SCRAP', value: '${gameState.value?.scrap ?? 0}kg', color: Colors.orangeAccent),
          _TelemetryItem(label: 'STRESS', value: '${(gameState.value?.stress_level ?? 0 * 100).toInt()}%', color: Colors.redAccent),
        ],
      ),
    );
  }
}

class _TelemetryItem extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _TelemetryItem({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label, style: const TextStyle(color: Colors.white24, fontSize: 10, fontWeight: FontWeight.bold)),
        const SizedBox(width: 8),
        Text(value, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold, fontFamily: 'monospace')),
      ],
    );
  }
}

class _Sidebar extends ConsumerWidget {
  const _Sidebar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeTab = ref.watch(activeMainTabProvider);
    
    return Container(
      width: 120,
      color: const Color(0xFF131318),
      child: Column(
        children: [
          const SizedBox(height: 16),
          if (activeTab == MainTab.roster) ...[
            _SidebarItem(
              icon: Icons.groups, 
              label: 'ACTIVE', 
              isActive: ref.watch(rosterSubTabProvider) == RosterSubTab.active,
              onTap: () => ref.read(rosterSubTabProvider.notifier).state = RosterSubTab.active,
            ),
            _SidebarItem(
              icon: Icons.strikethrough_s, 
              label: 'STAGED', 
              isActive: ref.watch(rosterSubTabProvider) == RosterSubTab.staged,
              onTap: () => ref.read(rosterSubTabProvider.notifier).state = RosterSubTab.staged,
            ),
            _SidebarItem(
              icon: Icons.inventory_2, 
              label: 'RESERVES', 
              isActive: ref.watch(rosterSubTabProvider) == RosterSubTab.reserves,
              onTap: () => ref.read(rosterSubTabProvider.notifier).state = RosterSubTab.reserves,
            ),
          ],
          if (activeTab == MainTab.ops) ...[
             _SidebarItem(icon: Icons.assignment, label: 'QUESTS', isActive: false, onTap: () {}),
             _SidebarItem(icon: Icons.history, label: 'AAR', isActive: false, onTap: () {}),
          ],
        ],
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _SidebarItem({required this.icon, required this.label, required this.isActive, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final color = isActive ? AppTheme.primaryAccent : Colors.white24;
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 64,
        width: 120,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(height: 4),
            Text(label, style: TextStyle(color: color, fontSize: 9, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

class _RosterView extends ConsumerWidget {
  const _RosterView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rosterAsync = ref.watch(rosterProvider);

    return rosterAsync.when(
      data: (roster) => GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.4,
        ),
        itemCount: roster.length,
        itemBuilder: (context, index) => SlimeCard(slime: roster[index]),
      ),
      loading: () => const Center(child: CircularProgressIndicator(strokeWidth: 2)),
      error: (err, _) => Center(child: Text('LOAD ERROR: $err', style: const TextStyle(color: Colors.red))),
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
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _BottomTabItem(
            icon: Icons.fingerprint, 
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
    final color = isActive ? AppTheme.primaryAccent : Colors.white38;
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 2),
            Text(label, style: TextStyle(color: color, fontSize: 9, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
