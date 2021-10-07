import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CryptoChartSyncfusion extends StatefulWidget {
  @override
  _CryptoChartSyncfusionState createState() => _CryptoChartSyncfusionState();
}

class _CryptoChartSyncfusionState extends State<CryptoChartSyncfusion> {
  @override
  Widget build(BuildContext context) {
    List<SalesData> chartData = [
      SalesData(9.0, 36987),
      SalesData(10.0, 34865),
      SalesData(11.0, 33258),
      SalesData(12.0, 35800),
      SalesData(13.0, 34200),
      SalesData(14.0, 38421),
      SalesData(15.0, 36500),
      SalesData(16.0, 38000),
      SalesData(17.0, 37684),
      SalesData(18.0, 39950)
    ];

    final List<Color> color = <Color>[];
    color.add(Colors.blue[50]);
    color.add(Colors.blue[100]);
    color.add(Colors.blue[200]);
    color.add(Colors.blue[300]);
    color.add(Colors.blue[400]);
    color.add(Colors.blue[500]);
    color.add(Colors.blue[600]);
    color.add(Colors.blue[700]);
    color.add(Colors.blue[800]);
    color.add(Colors.blue[900]);

    final List<double> stops = <double>[];
    stops.add(0.1);
    stops.add(0.2);
    stops.add(0.3);
    stops.add(0.4);
    stops.add(0.5);
    stops.add(0.6);
    stops.add(0.7);
    stops.add(0.8);
    stops.add(0.9);
    stops.add(1.0);

    final LinearGradient gradientColors =
        LinearGradient(colors: color, stops: stops);

    return Container(
      child: SfCartesianChart(
        series: <ChartSeries>[
          // Renders area chart
          AreaSeries<SalesData, double>(
              dataSource: chartData,
              xValueMapper: (SalesData sales, _) => sales.year,
              yValueMapper: (SalesData sales, _) => sales.sales,
              gradient: gradientColors),
        ],
      ),
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);

  final double year;
  final int sales;
}
