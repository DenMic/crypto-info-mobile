import 'package:charts_flutter/flutter.dart' as charts;
import 'package:crypto_info/common/client/assets_client.dart';

class TimeSeriesValue {
  final DateTime time;
  final double value;

  TimeSeriesValue(this.time, this.value);
}

Future<List<charts.Series<TimeSeriesValue, DateTime>>> getHistoryCryptoValue({String idAsset, String intervalType, int dateFrom}) async {
  var cryptoHistories = await getHisotryAssetAsync(idAsset: idAsset, intervalType: intervalType, dateFrom: dateFrom);
  var timeSeriesList = cryptoHistories.map((e) => TimeSeriesValue(e.date, e.priceUsd));

  return [
      new charts.Series<TimeSeriesValue, DateTime>(
        id: 'Value',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesValue sales, _) => sales.time,
        measureFn: (TimeSeriesValue sales, _) => sales.value,
        data: timeSeriesList.toList(),
      )
    ];
}