import 'package:flutter/material.dart';
import 'package:flutter_application_1/custom/line_chart.dart';
import 'package:flutter_application_1/screens/navdrawer.dart';

class WeeklyInsightsScreen extends StatelessWidget {
  const WeeklyInsightsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.blue[800],
          title: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Weekly Insights"),
          ),
          // centerTitle: true,
        ),
        body:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          const Text("Weekly Insights: "),
          Column(
            children: const [
              LineChart(),
            ],
          ),
          Column(
            children: const [
              Text("Recommendations:"),
              Text("Insert Recommendation here...")
            ],
          ),
        ]),
      ),
    );
  }
}
