import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/food_class.dart';
import 'package:flutter_application_1/screens/navdrawer.dart';

import '../custom/border_box.dart';
import '../models/daily_logs_class.dart';

class DailyLogScreen extends StatelessWidget {
  const DailyLogScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.blue[800],
          title: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Daily Log"),
          ),
          centerTitle: true,
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const BorderBox(
                padding: EdgeInsets.all(8.0),
                width: 60,
                height: 60,
                child: Icon(
                  Icons.home,
                  color: Colors.black,
                ),
              ),
              BorderBox(
                padding: const EdgeInsets.all(8.0),
                width: 60,
                height: 60,
                child: TextButton(
                  onPressed: () async {
                    await Navigator.pushNamed(context, '/DailyLogging');
                  },
                  child: const Icon(Icons.list, color: Colors.black),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
              BorderBox(
                padding: const EdgeInsets.all(8.0),
                width: 60,
                height: 60,
                child: TextButton(
                  onPressed: () async {
                    await Navigator.pushNamed(context, '/LoggingFood');

                    ///ItemInfo'
                  },
                  child: const Icon(Icons.add, color: Colors.black),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
              BorderBox(
                padding: const EdgeInsets.all(8.0),
                width: 60,
                height: 60,
                child: TextButton(
                  onPressed: () async {
                    await Navigator.pushNamed(context, '/Insights');
                  },
                  child: const Icon(Icons.graphic_eq, color: Colors.black),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
              BorderBox(
                padding: const EdgeInsets.all(8.0),
                width: 60,
                height: 60,
                child: TextButton(
                  onPressed: () {},
                  child: const Icon(Icons.settings, color: Colors.black),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text("Carbs: 158g"),
                  Text("Protein: 70g"),
                  Text("Fat: 65g"),
                ],
              ),
              Column(
                children: [
                  const Text("Breakfast"),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Table(
                      border: TableBorder.all(),
                      children: const [
                        TableRow(
                          children: [
                            SizedBox(
                              height: 48,
                              child: Text("3 Eggs"),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            SizedBox(
                              height: 48,
                              child: Text("2 Medium Toast "),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  const Text("Lunch"),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Table(
                      border: TableBorder.all(),
                      children: const [
                        TableRow(
                          children: [
                            SizedBox(
                              height: 48,
                              child: Text("Fajita Wrap"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  const Text("Dinner"),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Table(
                      border: TableBorder.all(),
                      children: const [
                        TableRow(
                          children: [
                            SizedBox(
                              height: 48,
                              child: Text("2 Tbsp Labneh"),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            SizedBox(
                              height: 48,
                              child: Text("1 Medium Toast "),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  const Text("Snack"),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Table(
                      border: TableBorder.all(),
                      children: const [
                        TableRow(
                          children: [
                            SizedBox(
                              height: 48,
                              child: Text("Chocolate Bar"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ]),
      ),
    );
  }
}
