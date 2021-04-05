import 'dart:convert';

import 'package:crypto_info/model/shared_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

// not in use
class SettingsPreference {
  static const String _nameSettings = 'CryptoInfoSettings';

  static Future<SharedSettingsModel> getSharedSettings() async {
    var prefs = await SharedPreferences.getInstance();
    var jsonSettings = prefs.getString(_nameSettings);

    if(jsonSettings == null || jsonSettings == "") {
      return SharedSettingsModel(currency: 'USD', lang: 'en');
    }

    return SharedSettingsModel.fromJson(json.decode(jsonSettings));
  }

  static Future setSharedSettings({String lang, String currency}) async {
    var prefs = await SharedPreferences.getInstance();
    var settingsMap = await getSharedSettings();

    if(lang != null)
      settingsMap.lang = lang;

    if(currency != null)
      settingsMap.currency = currency;

    await prefs.setString(_nameSettings, json.encode(settingsMap.toJson()));
  }
}