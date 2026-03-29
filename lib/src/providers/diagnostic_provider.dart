import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Tracks the round-trip latency of the last Flutter-Rust Bridge call in microseconds.
final bridgeLatencyProvider = StateProvider<int>((ref) => 0);
