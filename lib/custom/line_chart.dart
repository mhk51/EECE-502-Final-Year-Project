import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LineChart extends StatefulWidget {
  const LineChart({Key? key}) : super(key: key);

  @override
  _LineChartState createState() => _LineChartState();
}

class _LineChartState extends State<LineChart> {
  //late List<LoggedBSL> chartData; // = [
  //LoggedBSL(22, 2018),
  //LoggedBSL(26, 2019),
  //LoggedBSL(38, 2020),
  //LoggedBSL(25, 2021),
  //LoggedBSL(27, 2022),
  // ];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      margin: const EdgeInsets.all(8.0),
      child: SfCartesianChart(
        title: ChartTitle(text: "Blood Sugar Data"),
        primaryXAxis: DateTimeAxis(
            minimum: DateTime.now()
                .subtract(const Duration(hours: 5, minutes: 59, seconds: 59)),
            intervalType: DateTimeIntervalType.hours,
            desiredIntervals: 1,
            interval: 1,
            maximum: DateTime.now()
                .add(const Duration(hours: 5, minutes: 59, seconds: 59))),
        primaryYAxis: NumericAxis(
            title: AxisTitle(
              text: "Blood Glucose mmol/L",
              // alignment: ChartAlignment.far,
            ),
            minimum: 1,
            maximum: 15),
        series: [
          LineSeries(
              dataSource: LoggedBSL.chartData,
              xValueMapper: (LoggedBSL logg, _) => logg.time,
              yValueMapper: (LoggedBSL logg, _) => logg.level)
        ],
      ),
    );
  }
}

class LoggedBSL {
  static List<LoggedBSL> chartData = [];
  late final double level;
  late final DateTime time;

  LoggedBSL(this.level, this.time);
}
