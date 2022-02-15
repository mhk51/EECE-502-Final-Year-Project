import 'package:flutter/material.dart';

class DailyLogScreen extends StatelessWidget {
  const DailyLogScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[800],
          title: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Daily Log"),
          ),
          // centerTitle: true,
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
