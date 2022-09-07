import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:localization_riverpod_flutter/src/counter_page/counter_page.dart';
import 'package:localization_riverpod_flutter/src/localization/app_localizations_context.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      restorationScopeId: 'app',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (BuildContext context) => context.loc.appTitle,
      home: const CounterPage(),
    );
  }
}
