import 'package:crypto_info/common/client/assets_client.dart';
import 'package:crypto_info/page/home/component/crypto_list_item.dart';
import 'package:crypto_info/model/crypto_asset.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChoseCrypto extends StatefulWidget {
  ChoseCrypto({Key key}) : super(key: key);

  @override
  _ChoseCryptoState createState() => _ChoseCryptoState();
}

class _ChoseCryptoState extends State<ChoseCrypto> {
  List<String> _favoriteCrypto;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  _loadPreferences() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      var list = prefs.getStringList('favoriteCryptos');
      _favoriteCrypto = list ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget body;

    if (_favoriteCrypto == null) {
      body = Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SizedBox(
            child: CircularProgressIndicator(),
            height: 50.0,
            width: 50.0,
          ),
        ),
      );
    }

    body = FutureBuilder<List<CryptoAsset>>(
      future: fetchAssetsAsync(limit: null),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Widget> cryptoList = [];

          for (var crypto in snapshot.data) {
            cryptoList.add(CryptoListItem(
              crypto: crypto,
              preference: true,
            ));
          }

          return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 45.0),
                  child: Container(
                    child: ListView(
                      padding: const EdgeInsets.all(10),
                      children: cryptoList,
                    ),
                  ),
                ),

                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 17.0, top: 10, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Icon(Icons.arrow_back_outlined),
                          ),
                        ),
                        Text(
                          "Crypto preference",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
                
              ]);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: SizedBox(
              child: CircularProgressIndicator(),
              height: 50.0,
              width: 50.0,
            ),
          ),
        );
      },
    );

    return Scaffold(
        body: SafeArea(
      child: body,
    ));
  }
}
