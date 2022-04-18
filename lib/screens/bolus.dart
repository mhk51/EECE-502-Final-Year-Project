// ignore_for_file: empty_catches

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
import 'package:flutter_application_1/services/therapy_database.dart';

import '../custom/constants.dart';

class Bolus extends StatefulWidget {
  const Bolus({Key? key}) : super(key: key);

  @override
  State<Bolus> createState() => _BolusState();
}

class _BolusState extends State<Bolus> {
  final controller = TextEditingController(text: 0.00.toString());
  final _auth = AuthService();
  List<String> mealType = ["Breakfast", "Lunch", "Dinner", "Snack"];
  String mealValue = "Breakfast";

  Future<Map<String, dynamic>> test(String mealType) async {
    String userUID = _auth.getUID();
    // List<LoggedBSL> bslList =
    //     await BloodSugarDatabaseService(uid: userUID).getBSLDocs(mealType);
    // List<FoodClass> foodList =
    //     await FoodDatabaseService(uid: userUID).getFoodLogs(mealType);

    // List<String> recipeList =
    //     await RecipeDatabaseService(uid: userUID, recipeName: '')
    //         .getAllRecipes();
    Map<String, double> therapyParams =
        await TherapyDatabaseService(uid: userUID).getTherapyParams();
    List<LoggedBSL> bslList = [];
    List<FoodClass> foodList = [];
    List<String> recipeList = ['My Recipe'];

    double bslevel = 0.0;
    for (int i = 0; i < bslList.length; i++) {
      bslevel = (bslList[i].level).toDouble();
    }
    double totalCarbs = 0.0;
    for (int i = 0; i < foodList.length; i++) {
      totalCarbs += (foodList[i].carbs);
    }
    return {
      'carbs': totalCarbs,
      'bslevel': bslevel,
      'recipeList': recipeList,
      'glucoseTarget': therapyParams['glucoseTarget'],
      'carbohydratesRatio': therapyParams['carbohydratesRatio'],
      'insulinSensitivity': therapyParams['insulinSensitivity']
    };
  }

  Widget widgetfromString(String text) {
    return Text(text);
  }

  double insulinUnits = 0.0;

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
            double bloodSugarLevel = snapshot.data!['bslevel'];
            double carbs = ((snapshot.data!['carbs']! * 100).round() / 100);
            double glucoseTarget = snapshot.data!['glucoseTarget'];
            double carbohydratesRatio = snapshot.data!['carbohydratesRatio'];
            double insulinSensitivity = snapshot.data!['insulinSensitivity'];
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
                        title: Text(
                            'Total bolus: ${insulinUnits.floor()}-${insulinUnits.ceil()} units'),
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
                                      text:
                                          '${insulinUnits.floor()}-${insulinUnits.ceil()} units',
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Expanded(
                          flex: 1,
                          child: Icon(
                            Icons.water_drop,
                            size: 30,
                          ),
                        ),
                        const Expanded(
                          flex: 1,
                          child: Text('Glucose'),
                        ),
                        Expanded(
                          flex: 5,
                          child: Container(
                            height: 40,
                            width: 150,
                            color: const Color.fromARGB(255, 255, 188, 164),
                            padding: const EdgeInsets.fromLTRB(10, 0, 60, 2),
                            margin: const EdgeInsets.fromLTRB(50, 0, 40, 0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: TextField(
                                    decoration: const InputDecoration(
                                        hintText: '00.0',
                                        contentPadding: EdgeInsets.all(0)),
                                    onChanged: (val) {
                                      try {
                                        bloodSugarLevel = double.parse(val);
                                      } catch (e) {}
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  'mmol/L',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Expanded(
                          flex: 1,
                          child: Icon(
                            Icons.food_bank,
                            size: 35,
                          ),
                        ),
                        const Expanded(
                          flex: 1,
                          child: Text('Carbs'),
                        ),
                        Expanded(
                          flex: 5,
                          child: Container(
                            height: 40,
                            padding: const EdgeInsets.fromLTRB(10, 0, 3, 2),
                            margin: const EdgeInsets.fromLTRB(50, 0, 0, 0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: TextField(
                                    decoration: const InputDecoration(
                                        hintText: '000.00',
                                        contentPadding: EdgeInsets.all(0)),
                                    onChanged: (val) {
                                      // ignore: empty_catches
                                      try {
                                        carbs = double.parse(val);
                                      } catch (e) {}
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  'grams',
                                  style: TextStyle(fontSize: 16),
                                ),
                                const SizedBox(
                                  width: 36,
                                ),
                                FloatingActionButton(
                                    elevation: 0,
                                    onPressed: () {},
                                    child: const Icon(Icons.restaurant))
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Expanded(
                          flex: 1,
                          child: SizedBox(
                            width: 1,
                          ),
                        ),
                        const Expanded(
                          flex: 1,
                          child: Text('Protein'),
                        ),
                        Expanded(
                          flex: 5,
                          child: Container(
                            height: 40,
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 2),
                            margin: const EdgeInsets.fromLTRB(50, 0, 0, 0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: TextField(
                                    decoration: const InputDecoration(
                                        hintText: '000.00',
                                        contentPadding: EdgeInsets.all(0)),
                                    onChanged: (val) {},
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  'grams',
                                  style: TextStyle(fontSize: 16),
                                ),
                                const SizedBox(
                                  width: 86,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Expanded(
                          flex: 1,
                          child: SizedBox(
                            width: 1,
                          ),
                        ),
                        const Expanded(
                          flex: 1,
                          child: Text('Fats'),
                        ),
                        Expanded(
                          flex: 5,
                          child: Container(
                            height: 40,
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 2),
                            margin: const EdgeInsets.fromLTRB(50, 0, 0, 0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: TextField(
                                    decoration: const InputDecoration(
                                        hintText: '000.00',
                                        contentPadding: EdgeInsets.all(0)),
                                    onChanged: (val) {},
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  'grams',
                                  style: TextStyle(fontSize: 16),
                                ),
                                const SizedBox(
                                  width: 86,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Expanded(
                          flex: 1,
                          child: SizedBox(
                            width: 1,
                          ),
                        ),
                        const Expanded(
                          flex: 1,
                          child: Text('Calories'),
                        ),
                        Expanded(
                          flex: 5,
                          child: Container(
                            height: 40,
                            padding: const EdgeInsets.fromLTRB(10, 0, 20, 2),
                            margin: const EdgeInsets.fromLTRB(50, 0, 0, 0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: TextField(
                                    decoration: const InputDecoration(
                                        hintText: '0000.00',
                                        contentPadding: EdgeInsets.all(0)),
                                    onChanged: (val) {},
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  'kcal',
                                  style: TextStyle(fontSize: 16),
                                ),
                                const SizedBox(
                                  width: 86,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
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
                  //Hadi's take on bolus
                  Column(
                    children: [
                      DropdownButtonFormField<String>(
                        value: mealValue,
                        decoration: textInputDecoration,
                        items: mealType.map((sugar) {
                          return DropdownMenuItem(
                            value: sugar,
                            child: Text(sugar),
                          );
                        }).toList(),
                        onChanged: (val) => setState(() => mealValue = val!),
                      ),
                      // Text("Blood Sugar Level pre " +
                      //     mealValue +
                      //     ": $bloodSugarLevel"),
                      // Text("Carbs from " + mealValue + ": $carbs"),
                      OutlinedButton(
                          onPressed: () {
                            setState(() {
                              insulinUnits = (carbs / carbohydratesRatio +
                                  (bloodSugarLevel - glucoseTarget) /
                                      insulinSensitivity);
                            });
                          },
                          child: const Text('Calculate')),
                      Text("Estimated Insulin to take before " +
                          mealValue +
                          ": $carbs/{{Insulin to Carb Ratio}} + ($bloodSugarLevel - {{Target BSL}})/{{Sensitivity Factor}}"),
                      const Text(
                          "Important Note: Make sure to input an accurate measurment of BSL and input all meal in order to give you an accurate estimation of Insulin to take before the meal"),
                    ],
                  )
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
