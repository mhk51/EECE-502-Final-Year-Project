import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/auth.dart';
import 'package:flutter_application_1/services/bloodsugar_database.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LineChart extends StatefulWidget {
  const LineChart({Key? key}) : super(key: key);

  @override
  _LineChartState createState() => _LineChartState();
}

class _LineChartState extends State<LineChart> {
  final _auth = AuthService();
  LoggedBSL bslfromDoc(DocumentSnapshot doc) {
    return LoggedBSL(doc.get('BSL'), doc.get('time').toDate());
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<DocumentSnapshot>>(
        stream:
            BloodSugarDatabaseService(uid: _auth.getUID()).bloodSugarLogStream,
        builder: (context, snapshot) {
          // BloodSugarDatabaseService(uid: '1').test();
          if (snapshot.hasData) {
            List<LoggedBSL> list = snapshot.data!.map(bslfromDoc).toList();
            list.sort(((a, b) => a.time.compareTo(b.time)));
            return Container(
              height: 300,
              margin: const EdgeInsets.all(8.0),
              child: SfCartesianChart(
                // title: ChartTitle(text: "My Blood Sugar Data"),
                primaryXAxis: DateTimeAxis(
                    minimum: DateTime.now().subtract(
                        const Duration(hours: 11, minutes: 59, seconds: 59)),
                    intervalType: DateTimeIntervalType.hours,
                    desiredIntervals: 1,
                    interval: 1,
                    maximum: DateTime.now().add(
                        const Duration(hours: 1, minutes: 59, seconds: 59))),
                primaryYAxis: NumericAxis(
                    title: AxisTitle(
                      text: "Blood Glucose mmol/L",
                      // alignment: ChartAlignment.far,
                    ),
                    minimum: 1,
                    maximum: 30),
                series: [
                  LineSeries(
                      dataSource: list,
                      xValueMapper: (LoggedBSL logg, _) => logg.time,
                      yValueMapper: (LoggedBSL logg, _) => logg.level)
                ],
              ),
            );
          } else {
            return const Text('Loading');
          }
        });
  }
}

class LoggedBSL {
  static List<LoggedBSL> chartData = [];
  late final double level;
  late final DateTime time;

  LoggedBSL(this.level, this.time);
}
