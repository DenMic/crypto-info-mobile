import 'package:flutter/material.dart';
import 'package:crypto_info/page/home/component/top_crypto.dart';
import 'package:crypto_info/page/home/component/feed_component.dart';

class Home extends StatefulWidget {
  final Function changePage;

  Home({Key key, this.changePage}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    
    return ListView(
      children: [
        TopCrypto(),
        FeedComponent(changePage: widget.changePage)
      ],
    );
  }

}