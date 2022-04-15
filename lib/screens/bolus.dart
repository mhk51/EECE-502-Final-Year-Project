import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/custom/line_chart.dart';
import 'package:flutter_application_1/custom/loading.dart';
import 'package:flutter_application_1/models/food_class.dart';
import 'package:flutter_application_1/screens/navdrawer.dart';
import 'package:flutter_application_1/services/auth.dart';
import 'package:flutter_application_1/services/bloodsugar_database.dart';
import 'package:flutter_application_1/services/food_database.dart';
import 'package:flutter_application_1/services/recipe_database.dart';

class Bolus extends StatefulWidget {
  const Bolus({Key? key}) : super(key: key);

  @override
  State<Bolus> createState() => _BolusState();
}

class _BolusState extends State<Bolus> {
  final _auth = AuthService();

  Future<Map<String, dynamic>> test(String mealType) async {
    String userUID = _auth.getUID();
    List<LoggedBSL> bslList =
        await BloodSugarDatabaseService(uid: userUID).getBSLDocs(mealType);
    List<FoodClass> foodList =
        await FoodDatabaseService(uid: userUID).getFoodLogs(mealType);

    List<String> recipeList =
        await RecipeDatabaseService(uid: userUID, recipeName: '')
            .getAllRecipes();
    double bslevel = 0.0;
    for (int i = 0; i < bslList.length; i++) {
      bslevel = (bslList[i].level).toDouble();
    }
    double totalCarbs = 0.0;
    for (int i = 0; i < foodList.length; i++) {
      totalCarbs += (foodList[i].carbs);
    }
    return {'carbs': totalCarbs, 'bslevel': bslevel, 'recipeList': recipeList};
  }

  Widget widgetfromString(String text) {
    return Text(text);
  }

  int insulinUnits = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.indigo[800],
        title: const Text('Bolus Advisor'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: test('Breakfast'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            List<String> recipeList =
                snapshot.data!['recipeList'] as List<String>;
            String dropdownValue = recipeList[0];
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Card(
                    color: Colors.grey[300],
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: ExpansionTile(
                        expandedAlignment: Alignment.bottomLeft,
                        expandedCrossAxisAlignment: CrossAxisAlignment.start,
                        title: Text('Total bolus: $insulinUnits units'),
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: RichText(
                              text: TextSpan(
                                children: <TextSpan>[
                                  const TextSpan(
                                    text: 'Active Insulin: ',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 15),
                                  ),
                                  TextSpan(
                                      text: '$insulinUnits units',
                                      style: const TextStyle(
                                        color: Colors.green,
                                      ))
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15, top: 5),
                            child: InkWell(
                              child: const Text(
                                'Press for more details',
                                style: TextStyle(fontSize: 12),
                              ),
                              onTap: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Expanded(
                          flex: 1,
                          child: Icon(Icons.water_drop),
                        ),
                        const Expanded(
                          flex: 1,
                          child: Text('Glucose'),
                        ),
                        Expanded(
                            flex: 5,
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 80),
                              child: TextField(
                                onChanged: (val) {},
                              ),
                            )),
                      ],
                    ),
                  ),
                  Text(
                      'Carbs: ${((snapshot.data!['carbs']! * 100).round() / 100).toString()}\n Blood Sugar Level: ${snapshot.data!['bslevel'].toString()}'),
                  // Center(
                  //   child: DropdownButton<String>(
                  //     value: dropdownValue,
                  //     icon: const Icon(Icons.arrow_downward_outlined),
                  //     elevation: 16,
                  //     style: const TextStyle(color: Colors.deepPurple),
                  //     underline: Container(
                  //       height: 2,
                  //       color: Colors.deepPurpleAccent,
                  //     ),
                  //     onChanged: (String? newValue) {
                  //       setState(() {
                  //         dropdownValue = newValue!;
                  //       });
                  //     },
                  //     items: recipeList
                  //         .map<DropdownMenuItem<String>>((String value) {
                  //       return DropdownMenuItem<String>(
                  //         value: value,
                  //         child: Text(value),
                  //       );
                  //     }).toList(),
                  //   ),
                  // )
                ],
              ),
            );
          } else {
            return const Loading();
          }
        },
      ),
    );
  }
}
