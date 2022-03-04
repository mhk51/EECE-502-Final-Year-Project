import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/custom/app_icons_icons.dart';
import 'package:flutter_application_1/custom/constants.dart';
import 'package:flutter_application_1/screens/navdrawer.dart';
import 'package:flutter_application_1/screens/search.dart';

class LoggingFoodScreen extends StatefulWidget {
  const LoggingFoodScreen({Key? key}) : super(key: key);

  @override
  State<LoggingFoodScreen> createState() => _LoggingFoodScreenState();
}

class _LoggingFoodScreenState extends State<LoggingFoodScreen> {
  var msgController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        drawer: NavDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.blue[800],
          title: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Logging Food"),
          ),
          // centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: TextFormField(
                    controller: msgController,
                    decoration: textInputDecoration.copyWith(
                      hintText: 'Search Food',
                      suffixIcon: IconButton(
                        onPressed: () {
                          msgController.clear();
                        },
                        icon: const Icon(
                          Icons.cancel,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    validator: (val) =>
                        val!.isEmpty ? 'Enter a Username' : null,
                    onChanged: (val) {
                      setState(() => val);
                    },
                  ),
                ),
                const SizedBox(width: 20),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.search,
                    color: Colors.blue,
                    size: 30,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.center_focus_strong,
                    color: Colors.blue,
                    size: 30,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    AppIcons.barcode_2,
                    color: Colors.blue,
                    size: 27,
                  ),
                ),
                const SizedBox(
                  width: 20,
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {}, child: const Text("All Results")),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Favorites"),
                ),
                // Expanded(child: Search()),
              ],
            ),

            // Column(
            //   children: [
            //     Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: Table(
            //         border: TableBorder.all(),
            //         children: const [
            //           TableRow(
            //             children: [
            //               SizedBox(
            //                 height: 48,
            //                 child: Text("Option 1"),
            //               ),
            //             ],
            //           ),
            //           TableRow(
            //             children: [
            //               SizedBox(
            //                 height: 48,
            //                 child: Text("Option 2"),
            //               ),
            //             ],
            //           ),
            //           TableRow(
            //             children: [
            //               SizedBox(
            //                 height: 48,
            //                 child: Text("Option 3"),
            //               ),
            //             ],
            //           ),
            //           TableRow(
            //             children: [
            //               SizedBox(
            //                 height: 48,
            //                 child: Text("Option 4"),
            //               ),
            //             ],
            //           ),
            //           TableRow(
            //             children: [
            //               SizedBox(
            //                 height: 48,
            //                 child: Text("Option 5"),
            //               ),
            //             ],
            //           ),
            //         ],
            //       ),
            //     ),
            //   ],
            // ),
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
