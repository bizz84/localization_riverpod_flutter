import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:localization_riverpod_flutter/src/localization/app_localizations_provider.dart';

/// the actual counter
final counterProvider = StateProvider<int>((ref) {
  return 0;
});

/// a StateNotifier subclass that simulates an asynchronous computation
/// when incrementing the counter value
class CounterNotifier extends StateNotifier<AsyncValue<void>> {
  CounterNotifier(this.ref) : super(const AsyncData(null));
  final Ref ref;

  final _rng = Random();

  Future<void> increment() async {
    state = const AsyncLoading();
    await Future.delayed(const Duration(milliseconds: 500));
    // Simulate a failure every 2 attempts on average
    if (_rng.nextInt(2) != 0) {
      // if everything goes well, increment the counter
      ref.read(counterProvider.notifier).state++;
      state = const AsyncData(null);
    } else {
      // else, set an error
      final error = ref.read(appLocalizationsProvider).somethingWentWrong;
      state = AsyncError(error);
    }
  }
}

final counterNotifierProvider =
    StateNotifierProvider<CounterNotifier, AsyncValue<void>>((ref) {
  return CounterNotifier(ref);
});
