class SharedSettingsModel {
  String lang;
  String currency;

  SharedSettingsModel({this.lang, this.currency});

  factory SharedSettingsModel.fromJson(Map<String, dynamic> json) {
    return SharedSettingsModel(
      lang: json['lang'] as String,
      currency: json['currency'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'lang': lang,
        'currency': currency,
      };
}
