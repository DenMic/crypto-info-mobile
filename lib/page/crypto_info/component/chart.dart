/// Timeseries chart example
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:crypto_info/common/chart_data.dart';

class SimpleTimeSeriesChart extends StatelessWidget {
  final String idAsset;
  final String intervalType;
  final int dateFrom;

  SimpleTimeSeriesChart({this.idAsset, this.intervalType, this.dateFrom});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getHistoryCryptoValue(
          idAsset: idAsset, intervalType: intervalType, dateFrom: dateFrom),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: charts.TimeSeriesChart(
                snapshot.data,
                // Disable animations for image tests.
                animate: true,
                dateTimeFactory: const charts.LocalDateTimeFactory(),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          throw snapshot.error;
        }

        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: SizedBox(
              child: CircularProgressIndicator(),
              height: 50.0,
              width: 50.0,
            ),
          ),
        );
      },
    );
  }
}
