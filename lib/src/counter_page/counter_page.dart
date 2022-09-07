import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:localization_riverpod_flutter/src/counter_page/counter_notifier.dart';
import 'package:localization_riverpod_flutter/src/localization/app_localizations_context.dart';

class CounterPage extends ConsumerWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue>(counterNotifierProvider, (_, state) {
      // returned by MoodNotifier
      final error = state.error as String?;
      if (error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error)),
        );
      }
    });
    final counter = ref.watch(counterProvider);
    final counterState = ref.watch(counterNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(context.loc.counterPage),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              context.loc.buttonPushedTimes,
            ),
            Text(
              '$counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: counterState.isLoading
            ? null
            : () => ref.read(counterNotifierProvider.notifier).increment(),
        tooltip: context.loc.increment,
        child: counterState.isLoading
            ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
            : const Icon(Icons.add),
      ),
    );
  }
}
