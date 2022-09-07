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

## Preview

The UI of the sample app updates automatically when changing the locale from the system settings:

![Flutter localized counter preview](/.github/images/flutter-counter-localization.png)

### Testing on Android

To change the language on the Android emulator:

- swipe up from the bottom to reveal all the Settings app
- go to System > Languages & input and change the first language

> Note: changing the language on Android won't kill the running app

### Testing on iOS

To change the language on the iOS simulator:

- go to Settings > General > Language & Region > iPhone Language

> Note: when changing the language on iOS, your app will be killed by the OS and you'll have to restart it.

### [LICENSE: MIT](LICENSE.md)