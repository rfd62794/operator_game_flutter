import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:operator_game_flutter/src/rust/api/simple.dart';

part 'roster_provider.g.dart';

@riverpod
class Roster extends _$Roster {
  @override
  FutureOr<List<SlimeView>> build() async {
    // Initial fetch from the Rust bridge
    return getRoster();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async => getRoster());
  }

  // Future expansion: Add methods to stage/unstage slimes via the bridge
}
