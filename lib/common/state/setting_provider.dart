import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';

import '../settings_preference.dart';

class SettingProvider extends ChangeNotifier {
  String _valueCurrency = "USD";
  String _valueLanguage = "en";

  String get lang => _valueLanguage;

  // SettingProvider();
  SettingProvider({String currency, String language}){
    _valueCurrency = currency;
    _valueLanguage = language;
  }

  void setLanguage(String lang) {
    SettingsPreference.setSharedSettings(lang: lang);
    GlobalConfiguration().updateValue("lang", lang);
    
    _valueLanguage = lang;
    notifyListeners();
  }

  void setCurrency(String curr) {
    SettingsPreference.setSharedSettings(currency: curr);
    GlobalConfiguration().updateValue("currency", curr);
    
    _valueCurrency = curr;
    notifyListeners();
  }
}