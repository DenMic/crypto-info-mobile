import 'package:crypto_info/common/component/header_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CalculateCrypto extends StatefulWidget {
  CalculateCrypto({Key key}) : super(key: key);

  @override
  _CalculateCryptoState createState() => _CalculateCryptoState();
}

class _CalculateCryptoState extends State<CalculateCrypto> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          HeaderTitle(
            title: "Calculator",
            rightWidget: null,
          ),
          Card(
            margin: EdgeInsets.all(15.0),
            // padding: EdgeInsets.all(15.0),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 25.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 150,
                        child: TextField(
                          decoration: InputDecoration(labelText: "Enter value"),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ], // Only numbers can be entered
                        ),
                      ),
                    ],
                  ),
                   Row(
                    children: [
                      Container(
                        width: 150,
                        child: TextField(
                          readOnly: true,
                          decoration: InputDecoration(labelText: "Result value"),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ], // Only numbers can be entered
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
