import 'package:flutter/material.dart';
import 'package:flutter_application_1/custom/line_chart.dart';

class weeklyInsightsScreen extends StatelessWidget {
  const weeklyInsightsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
          Text("Weekly Insights: "),
          Column(
            children: [
              LineChart(),
            ],
          ),
          Column(
            children: [
              Text("Recommendations:"),
              Text("Insert Recommendation here...")
            ],
          ),
        ]),
      ),
    );
  }
}
