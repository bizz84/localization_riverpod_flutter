# Flutter counter example with Riverpod localization

This is an example of the Flutter counter app with localization support.

The project contains an `appLocalizationsProvider` that can be used to access localized strings outside the widgets, without using `BuildContext`:

```dart
/// provider used to access the AppLocalizations object for the current locale
final appLocalizationsProvider = Provider<AppLocalizations>((ref) {
  // 1. set the initial locale
  ref.state = lookupAppLocalizations(ui.window.locale);
  // 2. create an observer to update the state
  final observer = _LocaleObserver((locales) {
    ref.state = lookupAppLocalizations(ui.window.locale);
  });
  // 3. register the observer and dispose it when no longer needed
  final binding = WidgetsBinding.instance;
  binding.addObserver(observer);
  ref.onDispose(() => binding.removeObserver(observer));
  // 4. return the state
  return ref.state;
});

/// observed used to notify the caller when the locale changes
class _LocaleObserver extends WidgetsBindingObserver {
  _LocaleObserver(this._didChangeLocales);
  final void Function(List<Locale>? locales) _didChangeLocales;
  @override
  void didChangeLocales(List<Locale>? locales) {
    _didChangeLocales(locales);
  }
}

// given a Ref object, use it like this:
final loc = ref.read(appLocalizationsProvider);
print(loc.somethingWentWrong);
```

## [LICENSE: MIT](LICENSE.md)