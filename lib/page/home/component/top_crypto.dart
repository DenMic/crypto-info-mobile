import 'package:crypto_info/common/client/assets_client.dart';
import 'package:crypto_info/common/component/header_title.dart';
import 'package:crypto_info/page/home/component/crypto_list_item.dart';
import 'package:crypto_info/model/crypto_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TopCrypto extends StatefulWidget {
  TopCrypto({Key key}) : super(key: key);

  @override
  _TopCryptoState createState() => _TopCryptoState();
}

class _TopCryptoState extends State<TopCrypto> {
  Future<List<CryptoAsset>> futureCryptos;
  int limit = 10;

  void _changeLimit(int newLimit) {
    if (limit != newLimit) {
      setState(() {
        limit = newLimit;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    futureCryptos = fetchAssetsAsync(limit: limit);

    return FutureBuilder<List<CryptoAsset>>(
      future: futureCryptos,
      builder: (context, snapshot) {
        final heightLV = MediaQuery.of(context).size.height * 0.50;

        if (snapshot.hasData) {
          return Stack(children: [
            Padding(
              padding: const EdgeInsets.only(top: 55.0),
              child: Container(
                height: heightLV,
                child: ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return CryptoListItem(crypto: snapshot.data[index]);
                  },
                ),
              ),
            ),
            HeaderTitle(
              title: AppLocalizations.of(context).topAsserts,
              rightWidget: Row(
                children: [
                  MaterialButton(
                    minWidth: 0,
                    height: 35,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    color: limit == 10 ? Colors.grey[350] : Colors.white,
                    shape: CircleBorder(),
                    onPressed: () => _changeLimit(10),
                    child: Text(
                      '10',
                      style: TextStyle(color: Colors.grey[700], fontSize: 12),
                    ),
                  ),
                  MaterialButton(
                    minWidth: 0,
                    height: 35,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    color: limit == 15 ? Colors.grey[350] : Colors.white,
                    shape: CircleBorder(),
                    onPressed: () => _changeLimit(15),
                    child: Text(
                      '15',
                      style: TextStyle(color: Colors.grey[700], fontSize: 12),
                    ),
                  ),
                  MaterialButton(
                    minWidth: 0,
                    height: 35,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    color: limit == 30 ? Colors.grey[350] : Colors.white,
                    shape: CircleBorder(),
                    onPressed: () => _changeLimit(30),
                    child: Text(
                      '30',
                      style: TextStyle(color: Colors.grey[700], fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ]);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        // By default, show a loading spinner.
        return Container(
          height: heightLV,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: SizedBox(
                child: CircularProgressIndicator(),
                height: 50.0,
                width: 50.0,
              ),
            ),
          ),
        );
      },
    );
  }
}
