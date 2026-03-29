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
        actions: [
          IconButton(
            onPressed: () => ref.read(rosterProvider.notifier).refresh(),
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: rosterAsync.when(
        data: (roster) {
          if (roster.isEmpty) {
            return const Center(
              child: Text('No slimes in roster. Time to breed!'),
            );
          }
          return RefreshIndicator(
            onRefresh: () => ref.read(rosterProvider.notifier).refresh(),
            child: ListView.separated(
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
        error: (err, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.redAccent, size: 48),
              const SizedBox(height: 16),
              Text('Sync Error: $err', style: const TextStyle(color: Colors.redAccent)),
              TextButton(
                onPressed: () => ref.read(rosterProvider.notifier).refresh(),
                child: const Text('RETRY'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {}, // Future: Add Slime / Shop
        backgroundColor: Colors.deepPurpleAccent,
        child: const Icon(Icons.add_shopping_cart),
      ),
    );
  }
}
