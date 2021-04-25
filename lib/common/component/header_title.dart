import 'package:flutter/material.dart';

class HeaderTitle extends StatelessWidget {
  final String title;
  final Widget rightWidget;

  HeaderTitle({Key key, this.title, this.rightWidget});

  @override
  Widget build(BuildContext context) {
    Widget wdg = rightWidget;
    if (wdg == null) {
      wdg = Container(
        height: 35,
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 17.0),
          child: Text(
            this.title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
        Spacer(),
        wdg
      ],
    );
  }
}
