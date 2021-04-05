import 'package:crypto_info/model/crypto_asset.dart';
import 'package:crypto_info/page/crypto_info/component/card_info.dart';
import 'package:crypto_info/page/crypto_info/component/crypto_history_chart.dart';
import 'package:flutter/material.dart';

class CryptoInfoPage extends StatefulWidget {
  final CryptoAsset crypto;

  CryptoInfoPage({Key key, this.crypto}) : super(key: key);

  @override
  _CryptoInfoPageState createState() => _CryptoInfoPageState();
}

class _CryptoInfoPageState extends State<CryptoInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                padding: const EdgeInsets.only(bottom: 10.0, top: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10.0, left: 10.0),
                        child: Icon(Icons.arrow_back_outlined),
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Image(
                            width: 25,
                            height: 25,
                            image: AssetImage(
                                'assets/images/crypto_128/${widget.crypto.symbol.toLowerCase()}.png')),
                      ),
                    ),
                    Text(
                      widget.crypto.name,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    Container(
                      height: 35,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: CardInfo(
                      crypto: widget.crypto,
                    ),
                  ),
                  CryptoHistoryChart(crypto: widget.crypto),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
