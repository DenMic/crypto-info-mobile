import 'package:crypto_info/common/const/date_value_const.dart';
import 'package:crypto_info/model/crypto_asset.dart';
import 'package:crypto_info/page/crypto_info/component/chart.dart';
import 'package:crypto_info/common/component/header_title.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CryptoHistoryChart extends StatefulWidget {
  final CryptoAsset crypto;

  CryptoHistoryChart({Key key, this.crypto}) : super(key: key);

  @override
  _CryptoHistoryChartState createState() => _CryptoHistoryChartState();
}

class _CryptoHistoryChartState extends State<CryptoHistoryChart> {
  final NumberFormat numberFormat = NumberFormat.simpleCurrency();
  int startDate = DateValueConst.oneDay;
  int indexSelect = 3;

  changeDate(int value, int index) {
    setState(() {
      indexSelect = index;
      startDate = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    var intervalDate = getCorrectintervalType();

    return Column(
      children: [
        HeaderTitle(
          title: "",
          rightWidget: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MaterialButton(
                minWidth: 0,
                height: 35,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                color: indexSelect == 0 ? Colors.grey[350] : Colors.white,
                shape: CircleBorder(),
                onPressed: () => changeDate(DateValueConst.oneDay, 0),
                child: Text(
                  '1d',
                  style: TextStyle(color: Colors.grey[700], fontSize: 12),
                ),
              ),
              MaterialButton(
                minWidth: 0,
                height: 35,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                color: indexSelect == 1 ? Colors.grey[350] : Colors.white,
                shape: CircleBorder(),
                onPressed: () => changeDate(DateValueConst.oneWeek, 1),
                child: Text(
                  '1w',
                  style: TextStyle(color: Colors.grey[700], fontSize: 12),
                ),
              ),
              MaterialButton(
                minWidth: 0,
                height: 35,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                color: indexSelect == 2 ? Colors.grey[350] : Colors.white,
                shape: CircleBorder(),
                onPressed: () => changeDate(DateValueConst.oneMonth, 2),
                child: Text(
                  '1m',
                  style: TextStyle(color: Colors.grey[700], fontSize: 12),
                ),
              ),
              MaterialButton(
                minWidth: 0,
                height: 35,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                color: indexSelect == 3 ? Colors.grey[350] : Colors.white,
                shape: CircleBorder(),
                onPressed: () => changeDate(DateValueConst.threeMonth, 3),
                child: Text(
                  '3m',
                  style: TextStyle(color: Colors.grey[700], fontSize: 12),
                ),
              ),
              MaterialButton(
                minWidth: 0,
                height: 35,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                color: indexSelect == 4 ? Colors.grey[350] : Colors.white,
                shape: CircleBorder(),
                onPressed: () => changeDate(DateValueConst.oneYear, 4),
                child: Text(
                  '1y',
                  style: TextStyle(color: Colors.grey[700], fontSize: 12),
                ),
              ),
              MaterialButton(
                minWidth: 0,
                height: 35,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                color: indexSelect == 5 ? Colors.grey[350] : Colors.white,
                shape: CircleBorder(),
                onPressed: () => changeDate(DateValueConst.all, 5),
                child: Text(
                  'All',
                  style: TextStyle(color: Colors.grey[700], fontSize: 12),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: SizedBox(
            height: 300,
            child: SimpleTimeSeriesChart(
              idAsset: widget.crypto.id,
              intervalType: intervalDate[0],
              dateFrom: intervalDate[1],
            ),
          ),
        ),
      ],
    );
  }

  List getCorrectintervalType() {
    var intervalType = "m30";
    var date = DateValueConst.oneDay;

    switch (indexSelect) {
      case 0:
        intervalType = "h1";
        date = DateValueConst.oneDay;
        break;

      case 1:
        intervalType = "h6";
        date = DateValueConst.oneWeek;
        break;

      case 2:
        intervalType = "h12";
        date = DateValueConst.oneMonth;
        break;

      case 3:
        intervalType = "d1";
        date = DateValueConst.threeMonth;
        break;

      case 4:
        intervalType = "d1";
        date = DateValueConst.oneYear;
        break;

      case 5:
        intervalType = "d1";
        date = DateValueConst.all;
        break;
    }

    return [intervalType, date];
  }
}
