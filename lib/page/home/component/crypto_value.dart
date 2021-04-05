import 'package:crypto_info/model/crypto_asset.dart';
import 'package:flutter/material.dart';
import 'package:crypto_info/common/client/assets_client.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:intl/intl.dart';

class CryptoValue extends StatelessWidget {
  final CryptoAsset crypto;
  NumberFormat _numberFormat;

  String _valueCurrency;
  double _eurValue;

  CryptoValue({Key key, this.crypto}) : super(key: key){
    _valueCurrency = GlobalConfiguration().get("currency");
    _eurValue = GlobalConfiguration().get("RateUsd");

    if(_valueCurrency == "EUR")
      _numberFormat = NumberFormat.simpleCurrency(locale: "it");
    else
      _numberFormat = NumberFormat.simpleCurrency(locale: "en");
  }

  @override
  Widget build(BuildContext context) {
    var cryptoPrice = crypto.priceUsd;
    if(_valueCurrency == "EUR")
      cryptoPrice = crypto.priceUsd / _eurValue;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text("${_numberFormat.format(cryptoPrice)}"),
        FutureBuilder<CryptoAsset>(
          future: fetchAssetAsync(idAsset: crypto.id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var chg = snapshot.data.changePercent24Hr;
              return Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "${chg.abs().toStringAsFixed(2)}% ",
                    style: TextStyle(color: chg >= 0 ? Colors.green : Colors.red),),
                  Icon(chg >= 0 ? Icons.arrow_upward : Icons.arrow_downward, 
                  size: 14,
                  color: chg >= 0 ? Colors.green : Colors.red,),
                ],
              );
            } else if (snapshot.hasError) {
              throw snapshot.error;
            }

            return Text("");
          },
        )
      ],
    );
  }
}
