import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
class lineChart extends StatefulWidget {
  const lineChart({ Key? key }) : super(key: key);

  @override
  _lineChartState createState() => _lineChartState();
}

class _lineChartState extends State<lineChart> {
  final List<loggedBSL> chartData = [
    loggedBSL(22,2018),
    loggedBSL(26,2019),
    loggedBSL(38,2020),
    loggedBSL(25,2021),
    loggedBSL(27,2022),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      margin: EdgeInsets.all(8.0),
      child: SfCartesianChart(
        title: ChartTitle(text: "Blood Sugar Data"),
        series: [
          LineSeries(dataSource: chartData, xValueMapper: (loggedBSL logg, _)=>logg.time, yValueMapper: (loggedBSL logg, _)=>logg.level)
        ],
      ),

      
    );
  }
}

class loggedBSL{
  final double level;
  final int time;

  loggedBSL(this.level, this.time);
}