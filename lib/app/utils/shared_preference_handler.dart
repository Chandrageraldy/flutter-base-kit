import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHandler {
  static SharedPreferences? _sharedPreferences;
  static const spLanguage = 'language';
  static const spIsDarkMode = 'isDarkMode';

  static String? getLanguage() {
    return _sharedPreferences?.getString(spLanguage);
  }

  static void putLanguage(String? lang) {
    _sharedPreferences?.setString(spLanguage, lang ?? 'en');
  }

  static bool? getIsDarkMode() {
    return _sharedPreferences?.getBool(spIsDarkMode);
  }

  static void putIsDarkMode(bool isDarkMode) {
    _sharedPreferences?.setBool(spIsDarkMode, isDarkMode);
  }
}
