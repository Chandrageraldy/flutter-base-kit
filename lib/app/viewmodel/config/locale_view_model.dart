import 'dart:io' show Platform;
import 'package:flutter/material.dart';

import 'package:flutter_base_kit/app/viewmodel/base_view_model.dart';
import 'package:flutter_base_kit/app/utils/shared_preference_handler.dart';

class LocaleViewModel extends BaseViewModel {
  late Locale _locale;

  LocaleViewModel() {
    _initLocale();
  }

  void _initLocale() {
    final savedLanguage = SharedPreferenceHandler.getLanguage();
    _locale = savedLanguage != null && savedLanguage.isNotEmpty ? Locale(savedLanguage) : Locale(Platform.localeName);
    notifyListeners();
  }

  Locale get locale => _locale;

  Future<void> setLocale(Locale locale) async {
    if (_locale != locale) {
      _locale = locale;
      SharedPreferenceHandler.putLanguage(locale.languageCode);
      notifyListeners();
    }
  }
}
