import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/custom/app_icons_icons.dart';
import 'package:flutter_application_1/custom/constants.dart';
import 'package:flutter_application_1/models/food_class.dart';
import 'package:flutter_application_1/screens/logging_food/food_search_list.dart';
import 'package:flutter_application_1/screens/navdrawer.dart';

class LoggingFoodScreen extends StatefulWidget {
  const LoggingFoodScreen({Key? key}) : super(key: key);

  @override
  State<LoggingFoodScreen> createState() => _LoggingFoodScreenState();
}

class _LoggingFoodScreenState extends State<LoggingFoodScreen> {
  var msgController = TextEditingController();
  String tempSearchWord = "";
  String searchWord = "";
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
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text("Input New Recipe"),
            ),
            const SizedBox(
              height: 20,
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
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 2.5,
                        ),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          msgController.clear();
                        },
                        icon: const Icon(
                          Icons.cancel,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    validator: (val) =>
                        val!.isEmpty ? 'Enter a Search Word' : null,
                    onChanged: (val) {
                      tempSearchWord = val;
                    },
                  ),
                ),
                const SizedBox(width: 20),
                IconButton(
                  onPressed: () {
                    setState(() {
                      searchWord = tempSearchWord;
                    });
                  },
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
            FoodSearchWidget(searchWord: searchWord),
          ],
        ),
      ),
    );
  }
}
