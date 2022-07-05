import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/weight.dart';

class Weights extends StatelessWidget {
  const Weights({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var weights = Provider.of<Iterable<BloodPressure>>(context).toList();

    if (weights.isEmpty) {
      return const SizedBox(
        height: 300,
        width: 600,
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Center(
            child: Text(
                'Looks like you have no weigh ins. Click the scale icon to get started.'),
          ),
        ),
      );
    }

    return TimeSeriesChart(
      _createSampleData(weights, context),
      animate: true,
      primaryMeasureAxis: const NumericAxisSpec(
        tickProviderSpec: BasicNumericTickProviderSpec(zeroBound: false),
      ),
    );
  }

  static List<Series<TimeSeriesWeight, DateTime>> _createSampleData(
      List<BloodPressure> weights, BuildContext context) {
    final data =
        weights.map((e) => TimeSeriesWeight(e.date, e.systolic, e.diastolic)).toList();

    data.sort((a, b) {
      return a.time.compareTo(b.time);
    });

    return [
      Series<TimeSeriesWeight, DateTime>(
        id: 'Systolic',
        colorFn: (_, __) => MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesWeight sales, _) => sales.time,
        measureFn: (TimeSeriesWeight sales, _) => sales.systolic,
        data: data,
      ),
      Series<TimeSeriesWeight, DateTime>(
        id: 'Diastolic',
        colorFn: (_, __) => MaterialPalette.green.shadeDefault,
        domainFn: (TimeSeriesWeight sales, _) => sales.time,
        measureFn: (TimeSeriesWeight sales, _) => sales.diastolic,
        data: data,
      ),
    ];
  }
}

/// Sample time series data type.
class TimeSeriesWeight {
  final DateTime time;
  final int systolic;
  final int diastolic;

  TimeSeriesWeight(this.time, this.systolic, this.diastolic);
}
