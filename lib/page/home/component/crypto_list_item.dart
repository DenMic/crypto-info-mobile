import 'package:crypto_info/model/crypto_asset.dart';
import 'package:crypto_info/page/home/component/crypto_value.dart';
import 'package:crypto_info/page/crypto_info/crypto_info.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CryptoListItem extends StatefulWidget {
  final CryptoAsset crypto;
  final bool preference;

  CryptoListItem({Key key, this.crypto, this.preference = false})
      : super(key: key);

  @override
  _CryptoListItemState createState() => _CryptoListItemState();
}

class _CryptoListItemState extends State<CryptoListItem> {
  List<String> _favoriteCrypto;

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  _loadCounter() async {
    if (widget.preference) {
      var prefs = await SharedPreferences.getInstance();
      setState(() {
        var list = prefs.getStringList('favoriteCryptos');
        _favoriteCrypto = list ?? [];
      });
    }
  }

  Widget getCorrectIcon() {
    Widget loveIcon;

    if (_favoriteCrypto.any((x) => x == widget.crypto.id)) {
      loveIcon = GestureDetector(
        onTap: () => removeFavorite(widget.crypto.id),
        child: Icon(
          Icons.favorite,
          color: Colors.red,
        ),
      );
    } else {
      loveIcon = GestureDetector(
        onTap: () => addFavorite(widget.crypto.id),
        child: Icon(Icons.favorite_border),
      );
    }

    return loveIcon;
  }

  void addFavorite(String idAssert) async {
    var prefs = await SharedPreferences.getInstance();
    var list = prefs.getStringList('favoriteCryptos');
    _favoriteCrypto = list ?? [];
    _favoriteCrypto.add(idAssert);

    setState(() {
      prefs.setStringList('favoriteCryptos', _favoriteCrypto);
    });
  }

  void removeFavorite(String idAssert) async {
    var prefs = await SharedPreferences.getInstance();
    var list = prefs.getStringList('favoriteCryptos');
    _favoriteCrypto = list ?? [];

    _favoriteCrypto.remove(idAssert);

    setState(() {
      prefs.setStringList('favoriteCryptos', _favoriteCrypto);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget rightItem;

    if (widget.preference) {
      if (_favoriteCrypto == null) {
        return Center(
          child: SizedBox(
            child: CircularProgressIndicator(),
            height: 50.0,
            width: 50.0,
          ),
        );
      }

      rightItem = getCorrectIcon();
    } else {
      rightItem = CryptoValue(crypto: widget.crypto);
    }

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CryptoInfoPage(
                  crypto: widget.crypto,
                )),
      ),
      child: Card(
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: Row(
          children: [
            Container(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: FutureBuilder<Container>(
                      future: checkAssetImg(widget.crypto.symbol.toLowerCase()),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return snapshot.data;
                        }

                        return Container(width: 40, height: 40);
                      }),
                ),
              ),
            ),
            Expanded(
              child: Text(
                "${widget.crypto.name}",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                child:
                    Align(alignment: Alignment.centerRight, child: rightItem),
              ),
            )
          ],
        ),
      ),
    );
  }

  // check if an assert crypto image exist
  Future<Container> checkAssetImg(String fileName) async {
    try {
      final bundle = DefaultAssetBundle.of(context);
      var imgPath = 'assets/images/crypto_128/${fileName}.png';
      await bundle.load(imgPath);
      return Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imgPath),
          ),
        ),
      );
    } catch (e) {
      return Container(
        width: 40,
        height: 40,
      );
    }
  }
}
