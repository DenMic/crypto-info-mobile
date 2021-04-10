import 'package:crypto_info/common/component/header_title.dart';
import 'package:crypto_info/common/settings_preference.dart';
import 'package:crypto_info/common/state/setting_provider.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String _valueCurrency;
  String _valueLanguage;

  @override
  void initState() {
    super.initState();
    _valueCurrency = GlobalConfiguration().get("currency");
    _valueLanguage = GlobalConfiguration().get("lang");
  }

  void setCurrency(String value, BuildContext context) {
    var setProvider = context.read<SettingProvider>();
    setProvider.setCurrency(value);

    setState(() {
      _valueCurrency = value;
    });
  }

  void setLanguage(String value, BuildContext context) {
    var setProvider = context.read<SettingProvider>();
    setProvider.setLanguage(value);

    setState(() {
      _valueLanguage = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          HeaderTitle(
              title: AppLocalizations.of(context).settings, rightWidget: null),
          Expanded(
            child: ListView(
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(AppLocalizations.of(context).currency),
                            DropdownButton(
                              elevation: 15,
                              value: _valueCurrency,
                              onChanged: (value) => setCurrency(value, context),
                              underline: Container(
                                height: 1,
                                color: Colors.grey,
                              ),
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black),
                              dropdownColor: Colors.grey[200],
                              items: [
                                DropdownMenuItem(
                                  value: "USD",
                                  child: Text("Dollar"),
                                ),
                                DropdownMenuItem(
                                  value: "EUR",
                                  child: Text("Euro"),
                                ),
                              ],
                            )
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(AppLocalizations.of(context).language),
                            DropdownButton(
                              elevation: 15,
                              value: _valueLanguage,
                              onChanged: (value) => setLanguage(value, context),
                              underline: Container(
                                height: 1,
                                color: Colors.grey,
                              ),
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black),
                              dropdownColor: Colors.grey[200],
                              items: [
                                DropdownMenuItem(
                                  value: "en",
                                  child: Text("English"),
                                ),
                                DropdownMenuItem(
                                  value: "it",
                                  child: Text("Italian"),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
