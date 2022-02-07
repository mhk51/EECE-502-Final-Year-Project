import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LineChart extends StatefulWidget {
  const LineChart({Key? key}) : super(key: key);

  @override
  _LineChartState createState() => _LineChartState();
}

class _LineChartState extends State<LineChart> {
  final List<LoggedBSL> chartData = [
    LoggedBSL(22, 2018),
    LoggedBSL(26, 2019),
    LoggedBSL(38, 2020),
    LoggedBSL(25, 2021),
    LoggedBSL(27, 2022),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      margin: const EdgeInsets.all(8.0),
      child: SfCartesianChart(
        title: ChartTitle(text: "Blood Sugar Data"),
        series: [
          LineSeries(
              dataSource: chartData,
              xValueMapper: (LoggedBSL logg, _) => logg.time,
              yValueMapper: (LoggedBSL logg, _) => logg.level)
        ],
      ),
    );
  }
}

class LoggedBSL {
  final double level;
  final int time;

  LoggedBSL(this.level, this.time);
}
