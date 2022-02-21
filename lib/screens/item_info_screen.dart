import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/navdrawer.dart';

class ItemInfoScreen extends StatelessWidget {
  const ItemInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.blue[800],
          title: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Item Info"),
          ),
          // centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text("Item Info:"),
            const TextField(
              decoration: InputDecoration(
                hintText: "Enter Serving Size:",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.text,
            ),
            //CupertinoSearchTextField(),
            Column(
              children: [
                const Text("Table of Nutritional Facts: "),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Table(
                    border: TableBorder.all(),
                    children: const [
                      TableRow(
                        children: [
                          SizedBox(
                            height: 48,
                            child: Text("Food Name"),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          SizedBox(
                            height: 48,
                            child: Text("Carbs: "),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          SizedBox(
                            height: 48,
                            child: Text("Protien: "),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          SizedBox(
                            height: 48,
                            child: Text("Fat: "),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          SizedBox(
                            height: 48,
                            child: Text("Sugar: "),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Text("Comment on food selected"),
            ElevatedButton(
              onPressed: () {},
              child: const Text("Add"),
            )
          ],
        ),
      ),
    );
  }
}
