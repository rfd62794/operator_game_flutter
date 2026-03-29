import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:operator_game_flutter/src/providers/roster_provider.dart';
import 'package:operator_game_flutter/src/rust/frb_generated.dart';
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
      title: 'OperatorGame',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const RosterView(),
    );
  }
}

class RosterView extends ConsumerWidget {
  const RosterView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rosterAsync = ref.watch(rosterProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('SLIME ROSTER', style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: const [
          _RefreshButton(),
        ],
      ),
      body: Stack(
        children: [
          rosterAsync.when(
            data: (roster) {
              if (roster.isEmpty) {
                return const _EmptyRosterView();
              }
              return RefreshIndicator(
                onRefresh: () => ref.read(rosterProvider.notifier).refresh(),
                child: ListView.separated(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(16),
                  itemCount: roster.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final slime = roster[index];
                    return Center(
                      child: SlimeCard(
                        slime: slime,
                        onStageToggle: () {
                          // Future: implement staging logic
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Toggling stage for ${slime.name}...')),
                          );
                        },
                      ),
                    );
                  },
                ),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => _ErrorView(error: err.toString()),
          ),
          if (rosterAsync.isRefreshing)
            const Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: LinearProgressIndicator(minHeight: 2),
            ),
          const Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _DiagnosticOverlay(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {}, // Future: Add Slime / Shop
        backgroundColor: Colors.deepPurpleAccent,
        child: const Icon(Icons.add_shopping_cart),
      ),
    );
  }
}

class _RefreshButton extends ConsumerWidget {
  const _RefreshButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isRefreshing = ref.watch(rosterProvider).isRefreshing;

    return IconButton(
      onPressed: isRefreshing ? null : () => ref.read(rosterProvider.notifier).refresh(),
      icon: isRefreshing 
          ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)) 
          : const Icon(Icons.refresh),
    );
  }
}

class _EmptyRosterView extends StatelessWidget {
  const _EmptyRosterView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.inventory_2_outlined, size: 64, color: Colors.white24),
          SizedBox(height: 16),
          Text('No slimes in roster. Time to breed!', style: TextStyle(color: Colors.white38)),
        ],
      ),
    );
  }
}

class _ErrorView extends ConsumerWidget {
  final String error;
  const _ErrorView({required this.error});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, color: Colors.redAccent, size: 48),
          const SizedBox(height: 16),
          Text('Sync Error: $error', style: const TextStyle(color: Colors.redAccent)),
          TextButton(
            onPressed: () => ref.read(rosterProvider.notifier).refresh(),
            child: const Text('RETRY'),
          ),
        ],
      ),
    );
  }
}
