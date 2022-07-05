import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/blood_pressure.dart';

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

  static List<Series<TimeSeriesBloodPressure, DateTime>> _createSampleData(
      List<BloodPressure> weights, BuildContext context) {
    final data =
        weights.map((e) => TimeSeriesBloodPressure(e.date, e.systolic, e.diastolic)).toList();

    data.sort((a, b) {
      return a.time.compareTo(b.time);
    });

    return [
      Series<TimeSeriesBloodPressure, DateTime>(
        id: 'Systolic',
        colorFn: (_, __) => MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesBloodPressure sales, _) => sales.time,
        measureFn: (TimeSeriesBloodPressure sales, _) => sales.systolic,
        data: data,
      ),
      Series<TimeSeriesBloodPressure, DateTime>(
        id: 'Diastolic',
        colorFn: (_, __) => MaterialPalette.green.shadeDefault,
        domainFn: (TimeSeriesBloodPressure sales, _) => sales.time,
        measureFn: (TimeSeriesBloodPressure sales, _) => sales.diastolic,
        data: data,
      ),
    ];
  }
}

/// Sample time series data type.
class TimeSeriesBloodPressure {
  final DateTime time;
  final int systolic;
  final int diastolic;

  TimeSeriesBloodPressure(this.time, this.systolic, this.diastolic);
}
