// ignore_for_file: empty_catches, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  Future<Map<String, dynamic>> fetchData(String mealType) async {
    String userUID = _auth.getUID();
    List responses = [];
    try {
      responses = await Future.wait([
        BloodSugarDatabaseService(uid: userUID).getBSLDocs(mealType),
        FoodDatabaseService(uid: userUID).getFoodLogs(mealType),
        RecipeDatabaseService(uid: userUID, recipeName: '').getAllRecipes(),
        TherapyDatabaseService(uid: userUID).getTherapyParams(),
      ]);
    } catch (e) {
      print(e);
    }

    List<LoggedBSL> bslList = responses[0] as List<LoggedBSL>;
    List<FoodClass> foodList = responses[1] as List<FoodClass>;
    List<String> recipeList = responses[2] as List<String>;
    Map<String, double> therapyParams = responses[3] as Map<String, double>;

    double bslevel = 0.0;
    for (int i = 0; i < bslList.length; i++) {
      bslevel = (bslList[i].level).toDouble();
    }
    double totalCarbs = 0.0;
    double totalProtein = 0.0;
    double totalFats = 0.0;
    double totalCalories = 0.0;
    for (int i = 0; i < foodList.length; i++) {
      totalCarbs += (foodList[i].carbs);
      totalProtein += foodList[i].protein;
      totalFats += foodList[i].fat;
      totalCalories += foodList[i].sugar * 4; //sugar grams to kcal
    }
    return {
      'carbs': totalCarbs,
      'fat': totalFats,
      'protein': totalProtein,
      'calories': totalCalories,
      'bslevel': bslevel,
      'recipeList': recipeList,
      'glucoseTarget': therapyParams['glucoseTarget'],
      'carbohydratesRatio': therapyParams['carbohydratesRatio'],
      'insulinSensitivity': therapyParams['insulinSensitivity']
    };
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Future<void> showInformationDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          final TextEditingController _textEditingController =
              TextEditingController();
          return AlertDialog(
            content: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                      "If you feel that the insulin recommendation is not accurate,\nplease input the correct one so that we can adjust the recommendation for the next time:"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Expanded(
                        flex: 1,
                        child: Text('Actual Insulin Needed'),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 40,
                          width: 150,
                          padding: const EdgeInsets.fromLTRB(10, 0, 50, 2),
                          margin: const EdgeInsets.fromLTRB(50, 0, 40, 0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: TextField(
                                  decoration: const InputDecoration(
                                      hintText: '00',
                                      contentPadding: EdgeInsets.all(0)),
                                  onChanged: (val) {},
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {},
                child: Text(
                  "Submit",
                  style: TextStyle(color: primaryColor),
                ),
              )
            ],
          );
        });
  }

  Widget widgetfromString(String text) {
    return Text(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 75, 58),
        title: const Text('Bolus Advisor'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchData('Breakfast'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            double bloodSugarLevel = snapshot.data!['bslevel'];
            double carbs = ((snapshot.data!['carbs']! * 100).round() / 100);
            double protein = ((snapshot.data!['protein']! * 100).round() / 100);
            double fat = ((snapshot.data!['fat']! * 100).round() / 100);
            double calories =
                ((snapshot.data!['calories']! * 100).round() / 100);
            double glucoseTarget = snapshot.data!['glucoseTarget'];
            double carbohydratesRatio = snapshot.data!['carbohydratesRatio'];
            double insulinSensitivity = snapshot.data!['insulinSensitivity'];
            // List<String> recipeList =
            //     snapshot.data!['recipeList'] as List<String>;
            // String? dropdownValue =
            //     recipeList.isNotEmpty ? recipeList[0] : null;
            return BolusListView(
              bloodSugarLevel: bloodSugarLevel,
              carbs: carbs,
              fat: fat,
              calories: calories,
              protein: protein,
              carbohydratesRatio: carbohydratesRatio,
              insulinSensitivity: insulinSensitivity,
              glucoseTarget: glucoseTarget,
            );
          } else {
            return const Loading();
          }
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class BolusListView extends StatefulWidget {
  double glucoseTarget;
  double bloodSugarLevel;
  double carbs;
  double protein;
  double fat;
  double calories;
  double carbohydratesRatio;
  double insulinSensitivity;
  BolusListView({
    Key? key,
    required this.carbohydratesRatio,
    required this.bloodSugarLevel,
    required this.calories,
    required this.carbs,
    required this.fat,
    required this.protein,
    required this.glucoseTarget,
    required this.insulinSensitivity,
  }) : super(key: key);

  @override
  State<BolusListView> createState() => _BolusListViewState();
}

class _BolusListViewState extends State<BolusListView> {
  double insulinUnits = 0.0;
  String mealValue = "Breakfast";
  List<String> mealType = ["Breakfast", "Lunch", "Dinner", "Snack"];
  @override
  Widget build(BuildContext context) {
    return ListView(
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
                          style: TextStyle(color: Colors.black, fontSize: 15),
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
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Expanded(
                flex: 1,
                child: Icon(
                  Icons.bloodtype,
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
                  padding: const EdgeInsets.fromLTRB(10, 0, 50, 2),
                  margin: const EdgeInsets.fromLTRB(50, 0, 40, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: widget.bloodSugarLevel != 0.0
                                  ? widget.bloodSugarLevel
                                      .toStringAsPrecision(4)
                                  : '00.00',
                              contentPadding: const EdgeInsets.all(0)),
                          onChanged: (val) {
                            try {
                              widget.bloodSugarLevel = double.parse(val);
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
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
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
                child: Text(' '),
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
                          decoration: InputDecoration(
                              hintText: widget.carbs != 0.0
                                  ? widget.carbs.toStringAsPrecision(4)
                                  : '000.00',
                              contentPadding: const EdgeInsets.all(0)),
                          onChanged: (val) {
                            try {
                              widget.carbs = double.parse(val);
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
                          backgroundColor: primaryColor,
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
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
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
                          decoration: InputDecoration(
                              hintText: widget.protein != 0.0
                                  ? widget.protein.toStringAsPrecision(4)
                                  : '000.00',
                              contentPadding: const EdgeInsets.all(0)),
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
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
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
                          decoration: InputDecoration(
                              hintText: widget.fat != 0.0
                                  ? widget.fat.toStringAsPrecision(4)
                                  : '000.00',
                              contentPadding: const EdgeInsets.all(0)),
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
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
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
                          decoration: InputDecoration(
                              hintText: widget.calories != 0.0
                                  ? widget.calories.toStringAsPrecision(4)
                                  : '000.00',
                              contentPadding: const EdgeInsets.all(0)),
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
                    insulinUnits = (widget.carbs / widget.carbohydratesRatio +
                        (widget.bloodSugarLevel - widget.glucoseTarget) /
                            widget.insulinSensitivity);
                  });
                },
                child: const Text('Calculate')),
            // Text("Estimated Insulin to take before " +
            //     mealValue +
            //     ": ${widget.carbs}/{{Insulin to Carb Ratio}} + (${widget.bloodSugarLevel} - {{Target BSL}})/{{Sensitivity Factor}}"),
            // const Text(
            //     "Important Note: Make sure to input an accurate measurment of BSL and input all meal in order to give you an accurate estimation of Insulin to take before the meal"),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            //   child: Container(
            //     padding: const EdgeInsets.all(8.0),
            //     // width: 0.95 * size.width,
            //     alignment: Alignment.center,
            //     decoration: const BoxDecoration(
            //       color: Colors.white,
            //       borderRadius: BorderRadius.all(Radius.circular(20)),
            //     ),
            //     child: Column(
            //       children: [
            //         Text(
            //             "If you feel that the insulin recommendation is not accurate,\nplease input the correct one so that we can adjust the recommendation for the next time:"),
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             const Expanded(
            //               flex: 1,
            //               child: Text('Actual Insulin Needed'),
            //             ),
            //             Expanded(
            //               flex: 1,
            //               child: Container(
            //                 height: 40,
            //                 width: 150,
            //                 padding: const EdgeInsets.fromLTRB(10, 0, 50, 2),
            //                 margin: const EdgeInsets.fromLTRB(50, 0, 40, 0),
            //                 child: Row(
            //                   crossAxisAlignment: CrossAxisAlignment.end,
            //                   children: [
            //                     Expanded(
            //                       child: TextField(
            //                         decoration: const InputDecoration(
            //                             hintText: '00',
            //                             contentPadding: EdgeInsets.all(0)),
            //                         onChanged: (val) {
            //                           try {
            //                             widget.bloodSugarLevel =
            //                                 double.parse(val);
            //                           } catch (e) {}
            //                         },
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //             ),
            //           ],
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            Container(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () async {},
                child: const Text("Feedback",
                    style: TextStyle(
                      fontSize: 28,
                      fontFamily: 'Inria Serif',
                    )),
                style: ButtonStyle(
                  minimumSize:
                      MaterialStateProperty.all<Size>(const Size(314, 70)),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 255, 75, 58)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
