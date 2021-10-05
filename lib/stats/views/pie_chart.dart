/// Simple pie chart with outside labels example.
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class PieOutsideLabelChart extends StatelessWidget {
  const PieOutsideLabelChart(
    this.seriesList, {
    Key? key,
    this.animate = true,
  }) : super(key: key);

  /// Creates a [PieChart] with sample data and no transition.
  factory PieOutsideLabelChart.withSampleData() {
    return PieOutsideLabelChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  final List<charts.Series<dynamic, int>> seriesList;
  final bool animate;

  @override
  Widget build(BuildContext context) {
    return charts.PieChart<int>(
      seriesList,
      animate: animate,
      defaultRenderer: charts.ArcRendererConfig(
        arcWidth: 60,
        arcRendererDecorators: [charts.ArcLabelDecorator()],
      ),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearSales, int>> _createSampleData() {
    final data = [
      const LinearSales(0, 100),
      const LinearSales(1, 75),
      const LinearSales(2, 25),
      const LinearSales(3, 5),
    ];

    return [
      charts.Series<LinearSales, int>(
        id: 'Sales',
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
        // Set a label accessor to control the text of the arc label.
        labelAccessorFn: (LinearSales row, _) => '${row.year}: ${row.sales}',
      )
    ];
  }
}

/// Sample linear data type.
class LinearSales {
  const LinearSales(this.year, this.sales);

  final int year;
  final int sales;
}
