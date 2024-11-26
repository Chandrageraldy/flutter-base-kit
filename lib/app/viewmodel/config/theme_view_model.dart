import 'package:flutter/material.dart';

import 'package:flutter_base_kit/app/utils/shared_preference_handler.dart';
import 'package:flutter_base_kit/app/viewmodel/base_view_model.dart';
import 'package:flutter_base_kit/app/assets/theme_manager.dart';

class ThemeViewModel extends BaseViewModel {
  ThemeData _themeData = ThemeManager.lightMode;

  ThemeData get themeData => _themeData;

  void setTheme(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == ThemeManager.lightMode) {
      _themeData = ThemeManager.darkMode;
      SharedPreferenceHandler.putIsDarkMode(true);
    } else {
      _themeData = ThemeManager.lightMode;
      SharedPreferenceHandler.putIsDarkMode(false);
    }
    notifyListeners();
  }

  // CHECK IF APP USING SYSTEM THEME OR USER-CHOSEN THEME USING SHARED PREFERENCE
  void checkTheme() {
    bool? isDarkMode = SharedPreferenceHandler.getIsDarkMode();

    _themeData = isDarkMode == true ? ThemeManager.darkMode : ThemeManager.lightMode;

    notifyListeners();
  }
}
