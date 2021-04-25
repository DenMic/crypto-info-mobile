import 'package:crypto_info/common/component/header_title.dart';
import 'package:crypto_info/common/settings_preference.dart';
import 'package:crypto_info/common/state/setting_provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: HeaderTitle(
          title: AppLocalizations.of(context).settings,
          rightWidget: null,
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

  Widget _buildPopupDialog(BuildContext context) {
    return SimpleDialog(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: AppLocalizations.of(context).infoAppOne,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
                textLink('https://cointelegraph.com/about'),
                textLink('https://blog.coinbase.com/about'),
                textLink('https://news.bitcoin.com/about-bitcoin-news/'),
                textLink('https://www.newsbtc.com/about/'),
                TextSpan(
                  text: '\n${AppLocalizations.of(context).infoAppTwo}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  TextSpan textLink(String link) {
    return TextSpan(
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.blue,
      ),
      text: '\n$link',
      recognizer: TapGestureRecognizer()
        ..onTap = () async {
          if (await canLaunch(link)) {
            await launch(link);
          }
        },
    );
  }
}
