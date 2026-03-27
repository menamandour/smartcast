import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartcast/src/config/service_locator.dart';
import 'package:smartcast/src/core/constants/app_constants.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale(AppConstants.defaultLanguage);

  Locale get locale => _locale;

  LocaleProvider() {
    _loadSavedLocale();
  }

  void _loadSavedLocale() {
    final prefs = sl<SharedPreferences>();
    final String? languageCode = prefs.getString(AppConstants.languageKey);
    if (languageCode != null) {
      _locale = Locale(languageCode);
      notifyListeners();
    }
  }

  Future<void> setLocale(Locale locale) async {
    if (!['en', 'ar'].contains(locale.languageCode)) return;

    _locale = locale;
    final prefs = sl<SharedPreferences>();
    await prefs.setString(AppConstants.languageKey, locale.languageCode);
    notifyListeners();
  }
}

final localeProvider = LocaleProvider();
