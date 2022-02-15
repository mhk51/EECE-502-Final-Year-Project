import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoggingFoodScreen extends StatelessWidget {
  const LoggingFoodScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[800],
          title: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Picking Food"),
          ),
          // centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text("Logging Food: "),
            const CupertinoSearchTextField(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {}, child: const Text("All Results")),
                ElevatedButton(onPressed: () {}, child: const Text("Favorites"))
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Table(
                    border: TableBorder.all(),
                    children: const [
                      TableRow(
                        children: [
                          SizedBox(
                            height: 48,
                            child: Text("Option 1"),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          SizedBox(
                            height: 48,
                            child: Text("Option 2"),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          SizedBox(
                            height: 48,
                            child: Text("Option 3"),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          SizedBox(
                            height: 48,
                            child: Text("Option 4"),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          SizedBox(
                            height: 48,
                            child: Text("Option 5"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text("Input New Recipe"),
            )
          ],
        ),
      ),
    );
  }
}
