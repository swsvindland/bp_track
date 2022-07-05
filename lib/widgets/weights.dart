import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/weight.dart';

class Weights extends StatelessWidget {
  const Weights({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var weights = Provider.of<Iterable<Weight>>(context).toList();

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
      List<Weight> weights, BuildContext context) {
    final data =
        weights.map((e) => TimeSeriesWeight(e.date, e.weight)).toList();

    data.sort((a, b) {
      return a.time.compareTo(b.time);
    });

    final regression = [
      TimeSeriesWeight(data.first.time, data.first.weight),
      TimeSeriesWeight(data.last.time, data.last.weight)
    ];

    return [
      Series<TimeSeriesWeight, DateTime>(
        id: 'WeighIns',
        colorFn: (_, __) => MaterialPalette.pink.makeShades(10)[7],
        domainFn: (TimeSeriesWeight sales, _) => sales.time,
        measureFn: (TimeSeriesWeight sales, _) => sales.weight,
        data: data,
      ),
      Series<TimeSeriesWeight, DateTime>(
        id: 'Average',
        colorFn: (_, __) => MaterialPalette.pink.shadeDefault,
        domainFn: (TimeSeriesWeight sales, _) => sales.time,
        measureFn: (TimeSeriesWeight sales, _) => sales.weight,
        data: regression,
      ),
    ];
  }
}

/// Sample time series data type.
class TimeSeriesWeight {
  final DateTime time;
  final double weight;

  TimeSeriesWeight(this.time, this.weight);
}
