import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:operator_game_flutter/src/rust/api/simple.dart';
import 'package:operator_game_flutter/src/providers/diagnostic_provider.dart';

part 'roster_provider.g.dart';

@riverpod
class Roster extends _$Roster {
  @override
  FutureOr<List<SlimeView>> build() async {
    return _fetchRosterWithTiming();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async => _fetchRosterWithTiming());
  }

  Future<List<SlimeView>> _fetchRosterWithTiming() async {
    final sw = Stopwatch()..start();
    try {
      final roster = getRoster();
      sw.stop();
      // Defer state update to next microtask to avoid Riverpod build-phase exception
      Future.microtask(() {
        ref.read(bridgeLatencyProvider.notifier).state = sw.elapsedMicroseconds;
      });
      return roster;
    } catch (e) {
      sw.stop();
      rethrow;
    }
  }
}
