import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ThemeOption { light, dark, system }

class ThemeProvider with ChangeNotifier {
  ThemeOption _themeOption = ThemeOption.system;

  ThemeOption get themeOption => _themeOption;

  ThemeMode get themeMode {
    switch (_themeOption) {
      case ThemeOption.light:
        return ThemeMode.light;
      case ThemeOption.dark:
        return ThemeMode.dark;
      case ThemeOption.system:
        return ThemeMode.system;
    }
  }
  Future<void> setTheme(ThemeOption option) async {
    _themeOption = option;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme', option.name);
  }
  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTheme = prefs.getString('theme');

    if (savedTheme != null) {
      _themeOption = ThemeOption.values.firstWhere(
            (e) => e.name == savedTheme,
        orElse: () => ThemeOption.system,
      );
      notifyListeners();
    }
  }

}
