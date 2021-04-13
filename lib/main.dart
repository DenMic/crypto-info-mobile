import 'package:crypto_info/common/client/rates_client.dart';
import 'package:crypto_info/Page/rss_feed/rss_feed.dart';
import 'package:crypto_info/page/favorite_crypto/favorite_crypto.dart';
import 'package:crypto_info/page/calculate/calculate.dart';
import 'package:crypto_info/page/home/home.dart';
import 'package:crypto_info/page/settings/settings.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:crypto_info/common/settings_preference.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'common/state/setting_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var appSettings = await SettingsPreference.getSharedSettings();
  var appSettingsMap = appSettings.toJson();

  var rateEur = await getEurRateAsync();
  appSettingsMap["RateUsd"] = double.parse(rateEur.rateUsd);

  GlobalConfiguration().loadFromMap(appSettingsMap);

  runApp(
    ChangeNotifierProvider(
      create: (context) => SettingProvider(
          currency: appSettingsMap["currency"],
          language: appSettingsMap["lang"]),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      title: 'Crypto Info',
      themeMode: ThemeMode.system,
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: BasePage(title: 'Crypto Info'),
    );
  }
}

class BasePage extends StatefulWidget {
  final String title;

  BasePage({Key key, this.title}) : super(key: key);

  @override
  _BasePageState createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  PageController _pageController = PageController();
  String _valueLanguage;
  int _selectedIndex = 0;
  int _idFeed = -1;

  @override
  void initState() {
    super.initState();
    _valueLanguage = GlobalConfiguration().get("lang") ?? 'en';
  }

  void _onChangePage(int index) {
    if (_selectedIndex != index) {
      setState(
        () {
          _selectedIndex = index;
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
          );
        },
      );
    }
  }

  void _goToFeed(int index, int idFeed) {
    setState(() {
      _selectedIndex = index;
      _idFeed = idFeed;

      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingProvider>(
      builder: (context, setting, child) {
        return Localizations.override(
          context: context,
          locale: Locale(setting.lang),
          // Using a Builder here to get the correct BuildContext.
          child: Builder(
            builder: (BuildContext context) {
              return Scaffold(
                // appBar: AppBar(
                //   iconTheme: IconThemeData(color: Colors.black),
                //   backgroundColor: Colors.white,
                //   title: Text(widget.title, style: TextStyle(color: Colors.black)),
                // ),
                body: PageView(
                    controller: _pageController,
                    physics: NeverScrollableScrollPhysics(),
                    pageSnapping: true,
                    children: [
                      Home(changePage: _goToFeed),
                      FavoriteCrypto(),
                      RssFeedPage(idFeed: _idFeed),
                      // CalculateCrypto(),
                      // SafeArea(child: Text(AppLocalizations.of(context).)),
                      SettingsPage(),
                    ]),
                bottomNavigationBar: SnakeNavigationBar.color(
                  elevation: 15,
                  behaviour: SnakeBarBehaviour.pinned,
                  snakeShape: SnakeShape.indicator,
                  shape: null,
                  shadowColor: Colors.black,
                  padding: EdgeInsets.zero,

                  ///configuration for SnakeNavigationBar.color
                  snakeViewColor: Colors.black,
                  selectedItemColor:
                      SnakeShape.indicator == SnakeShape.indicator
                          ? Colors.black
                          : null,
                  unselectedItemColor: Colors.blueGrey,

                  showUnselectedLabels: false,
                  showSelectedLabels: false,

                  currentIndex: _selectedIndex,
                  onTap: _onChangePage,
                  items: [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home), label: 'Top Crypto'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.favorite), label: 'favorite'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.rss_feed), label: 'RSS'),
                    // BottomNavigationBarItem(
                    //     icon: Icon(Icons.calculate), label: 'Calculate'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.settings), label: 'Settings'),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
