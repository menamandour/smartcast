import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartcast/src/config/service_locator.dart';
import 'package:smartcast/src/core/constants/app_constants.dart';

class SettingsProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  String _fontFamily = 'Inter';

  ThemeMode get themeMode => _themeMode;
  String get fontFamily => _fontFamily;

  SettingsProvider() {
    _loadSavedSettings();
  }

  Future<void> _loadSavedSettings() async {
    final prefs = sl<SharedPreferences>();
    final String? savedTheme = prefs.getString(AppConstants.themeKey);
    final String? savedFont = prefs.getString(AppConstants.fontKey);

    if (savedTheme != null) {
      _themeMode = savedTheme == 'dark' ? ThemeMode.dark : ThemeMode.light;
    }
    if (savedFont != null) {
      _fontFamily = savedFont;
    }

    notifyListeners();
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    final prefs = sl<SharedPreferences>();
    await prefs.setString(AppConstants.themeKey, mode == ThemeMode.dark ? 'dark' : 'light');
    notifyListeners();
  }

  Future<void> setFontFamily(String fontFamily) async {
    _fontFamily = fontFamily;
    final prefs = sl<SharedPreferences>();
    await prefs.setString(AppConstants.fontKey, fontFamily);
    notifyListeners();
  }
}

final settingsProvider = SettingsProvider();
