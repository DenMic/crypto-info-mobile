import 'package:crypto_info/model/crypto_asset.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:intl/intl.dart';

class CardInfo extends StatelessWidget {
  final CryptoAsset crypto;
  NumberFormat _numberFormat;

  String _valueCurrency;
  double _eurValue;

  CardInfo({Key key, this.crypto}){
    _valueCurrency = GlobalConfiguration().get("currency");
    _eurValue = GlobalConfiguration().get("RateUsd");

    if(_valueCurrency == "EUR")
      _numberFormat = NumberFormat.simpleCurrency(locale: "it");
    else
      _numberFormat = NumberFormat.simpleCurrency(locale: "en");
  }

  @override
  Widget build(BuildContext context) {
    var price = crypto.priceUsd ?? 0;
    var marketCapUsd = crypto.marketCapUsd ?? 0;
    var supply = crypto.supply ?? 0;
    var maxSupply = crypto.maxSupply ?? 0;

    if(_valueCurrency == "EUR") {
      price = (crypto.priceUsd ?? 0) / _eurValue;
      marketCapUsd = (crypto.marketCapUsd ?? 0) / _eurValue;
      supply = (crypto.supply ?? 0) / _eurValue;
      maxSupply = (crypto.maxSupply ?? 0) / _eurValue;
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.star_border_outlined,
                    size: 18,
                  ),
                ),
                Text(
                  "Rank",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                Spacer(),
                Text(
                  "${crypto.rank}",
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Divider(height: 5),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.graphic_eq,
                    size: 18,
                  ),
                ),
                Text(
                  "Symbol",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                Spacer(),
                Text("${crypto.symbol}")
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Divider(height: 5),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.euro,
                    size: 18,
                  ),
                ),
                Text(
                  "Price",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                Spacer(),
                Text("${_numberFormat.format(price)}")
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Divider(height: 5),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.data_usage,
                    size: 18,
                  ),
                ),
                Text(
                  "Marketcap",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                Spacer(),
                Text("${_numberFormat.format(marketCapUsd)}")
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Divider(height: 5),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.pie_chart_outlined,
                    size: 18,
                  ),
                ),
                Text(
                  "Supply",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                Spacer(),
                Text("${_numberFormat.format(supply)}")
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Divider(height: 5),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.pie_chart,
                    size: 18,
                  ),
                ),
                Text(
                  "Max Supply",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                Spacer(),
                Text("${_numberFormat.format(maxSupply)}")
              ],
            ),
          ],
        ),
      ),
    );
  }
}
