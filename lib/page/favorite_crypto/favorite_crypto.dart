import 'package:crypto_info/model/crypto_asset.dart';
import 'package:crypto_info/page/home/component/crypto_list_item.dart';
import 'package:crypto_info/common/component/header_title.dart';
import 'package:flutter/material.dart';
import 'package:crypto_info/common/client/assets_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:crypto_info/page/chose_crypto/chose_crypto.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FavoriteCrypto extends StatefulWidget {
  FavoriteCrypto({Key key}) : super(key: key);

  @override
  _FavoriteCryptoState createState() => _FavoriteCryptoState();
}

class _FavoriteCryptoState extends State<FavoriteCrypto> {
  List<String> _favoriteCrypto;

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      var list = prefs.getStringList('favoriteCryptos');
      _favoriteCrypto = list ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget listCrypto;

    if (_favoriteCrypto == null) {
      listCrypto = Center(
        child: SizedBox(
          child: CircularProgressIndicator(),
          height: 50.0,
          width: 50.0,
        ),
      );
    } else {
      listCrypto = FutureBuilder<List<CryptoAsset>>(
          future: getListCryptoAssetAsync(idAssets: _favoriteCrypto),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.length > 0) {
                return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height - 135,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return CryptoListItem(crypto: snapshot.data[index]);
                        },
                      ),
                    ));
              } else {
                return Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      margin: const EdgeInsets.all(10),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text("No items were found"),
                            SizedBox(
                              height: 20,
                            ),
                            MaterialButton(
                              minWidth: 0,
                              height: 35,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              color: Colors.white,
                              onPressed: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChoseCrypto()),
                                );

                                _loadCounter();
                              },
                              child: Text(
                                'Add Crypto',
                                style: TextStyle(
                                    color: Colors.grey[700], fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
            } else if (snapshot.hasError) {
              throw snapshot.error;
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
          });
    }

    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          HeaderTitle(
            title: AppLocalizations.of(context).favoriteCrypto,
            rightWidget: MaterialButton(
              minWidth: 0,
              height: 35,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              color: Colors.white,
              shape: CircleBorder(),
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChoseCrypto()),
                );

                _loadCounter();
              },
              child: Text(
                'Add',
                style: TextStyle(color: Colors.grey[700], fontSize: 12),
              ),
            ),
          ),
          listCrypto
        ],
      ),
    );
  }
}
