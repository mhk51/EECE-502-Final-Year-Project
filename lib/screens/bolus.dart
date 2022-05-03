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
import 'package:flutter_application_1/services/food_stats_service.dart';
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
    List<String> foodNames = [];
    Map<String, double> data = {};
    double totalCarbs = 0.0;
    double totalProtein = 0.0;
    double totalFats = 0.0;
    double totalCalories = 0.0;

    for (FoodClass food in foodList) {
      foodNames.add(food.foodName);
    }
    if (foodList.isNotEmpty) {
      data =
          await FoodStatsService(uid: userUID).getCorrectionFactors(foodNames);
    }
    for (FoodClass food in foodList) {
      totalCarbs += (food.carbs) * data[food.foodName]!.toDouble();
      totalProtein += food.protein;
      totalFats += food.fat;
      totalCalories += food.sugar * 4;
    }
    return {
      'carbs': totalCarbs,
      'fat': totalFats,
      'protein': totalProtein,
      'calories': totalCalories,
      'foodNames': foodNames,
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

  String mealValue = "Breakfast";
  List<String> mealType = ["Breakfast", "Lunch", "Dinner", "Snack"];

  void dropDownMenuOnChanged(String val) {
    setState(() {
      mealValue = val;
    });
  }

  Future<void> showInformationDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  validator: (value) {
                    return value!.isNotEmpty ? null : "Invalid Field";
                  },
                  decoration:
                      const InputDecoration(hintText: "Enter Sugar Level"),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () async {},
                child: const Text(
                  "Submit",
                  style: TextStyle(color: primaryColor),
                ),
              )
            ],
          );
        });
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
        future: fetchData(mealValue),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            List<String> foodNames = snapshot.data!['foodNames'];
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
            // if (insulinSensitivity == -1 && carbohydratesRatio == -1) {
            //   showInformationDialog(context);
            // }
            return BolusListView(
              foodNames: foodNames,
              mealValue: mealValue,
              dropDownMenuOnChanged: dropDownMenuOnChanged,
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
  final List<String> foodNames;
  final Function dropDownMenuOnChanged;
  final String mealValue;
  final double glucoseTarget;
  double bloodSugarLevel;
  double carbs;
  final double protein;
  final double fat;
  final double calories;
  final double carbohydratesRatio;
  final double insulinSensitivity;
  BolusListView({
    Key? key,
    required this.foodNames,
    required this.mealValue,
    required this.dropDownMenuOnChanged,
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
  List<String> mealType = ["Breakfast", "Lunch", "Dinner", "Snack"];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Future<double?> showInformationDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          late double feedBackInsulin;
          final TextEditingController _textEditingController =
              TextEditingController();
          return AlertDialog(
            content: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                      "If you feel that the insulin recommendation is not accurate,\nplease input the correct one so that we can adjust the recommendation for the next time:",
                      style: TextStyle(
                        fontSize: 22,
                        fontFamily: 'Inria Serif',
                      )),
                  TextFormField(
                    onChanged: ((value) {
                      try {
                        feedBackInsulin = double.parse(value);
                      } catch (e) {}
                    }),
                    validator: (value) {
                      return value!.isNotEmpty ? null : "Invalid Field";
                    },
                    decoration: const InputDecoration(
                        hintText: "Actual Insulin Needed"),
                    controller: _textEditingController,
                    keyboardType: const TextInputType.numberWithOptions(
                        decimal: true, signed: false),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context, feedBackInsulin);
                },
                child: const Text(
                  "Submit",
                  style: TextStyle(color: primaryColor),
                ),
              )
            ],
          );
        });
  }

  double insulinUnits = 0.0;
  final _auth = AuthService();

  @override
  void initState() {
    super.initState();
    if (widget.insulinSensitivity == -1 || widget.carbohydratesRatio == -1) {
      WidgetsBinding.instance!.addPostFrameCallback((_) async {
        double carbohydratesRatio = -1;
        double insulinSensitivity = -1;
        await showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              final _formKey = GlobalKey<FormState>();
              return AlertDialog(
                contentPadding: EdgeInsets.zero,
                content: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Text(
                            'Title',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Divider(
                          thickness: 0.7,
                          color: Colors.grey[400],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: TextFormField(
                            cursorColor: Colors.indigo[800],
                            validator: (value) {
                              return value!.isNotEmpty ? null : "Invalid Field";
                            },
                            decoration: InputDecoration(
                              hintText: 'Insulin Sensitivity',
                              fillColor: Colors.grey[200],
                              filled: true,
                            ),
                            onChanged: (value) {
                              try {
                                insulinSensitivity = double.parse(value);
                              } catch (e) {}
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: TextFormField(
                            cursorColor: Colors.indigo[800],
                            validator: (value) {
                              return value!.isNotEmpty ? null : "Invalid Field";
                            },
                            decoration: InputDecoration(
                              hintText: 'Carbohydrates Ratio',
                              fillColor: Colors.grey[200],
                              filled: true,
                            ),
                            onChanged: (value) {
                              try {
                                carbohydratesRatio = double.parse(value);
                              } catch (e) {}
                            },
                          ),
                        ),
                      ],
                    )),
                actions: <Widget>[
                  Container(
                    margin: const EdgeInsets.all(8),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "CANCEL",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700],
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(8),
                    child: TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          TherapyDatabaseService(uid: _auth.getUID())
                              .updateTherapyParams(
                                  insulinSensitivity, carbohydratesRatio);
                          Navigator.pop(context);
                        }
                      },
                      style: TextButton.styleFrom(
                        primary: Colors.red,
                        backgroundColor: Colors.red,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Text(
                          "SAVE",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              );
            });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
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
                  'Total bolus: ${(insulinUnits * 10).round() / 10} units'),
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
                  height: 42,
                  width: 150,
                  color: const Color.fromARGB(255, 255, 188, 164),
                  padding: const EdgeInsets.fromLTRB(10, 6, 10, 2),
                  margin: const EdgeInsets.fromLTRB(50, 0, 10, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                              suffixIcon: const Icon(Icons.edit),
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
                      const SizedBox(width: 8)
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
                          decoration: InputDecoration(
                              suffixIcon: const Icon(Icons.edit),
                              hintText: widget.carbs != 0.0
                                  ? widget.carbs.toStringAsPrecision(4)
                                  : '00.00',
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
                              suffixIcon: const Icon(Icons.edit),
                              hintText: widget.protein != 0.0
                                  ? widget.protein.toStringAsPrecision(4)
                                  : '00.00',
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
                        width: 30,
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
                              suffixIcon: const Icon(Icons.edit),
                              hintText: widget.fat != 0.0
                                  ? widget.fat.toStringAsPrecision(4)
                                  : '00.00',
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
                        width: 30,
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
                              suffixIcon: const Icon(Icons.edit),
                              hintText: widget.calories != 0.0
                                  ? widget.calories.toStringAsPrecision(4)
                                  : '00.00',
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
                        width: 38,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Column(
          children: [
            SizedBox(
              height: 0.02 * size.height,
            ),
            DropdownButtonFormField<String>(
              value: widget.mealValue,
              decoration: textInputDecoration,
              items: mealType.map((sugar) {
                return DropdownMenuItem(
                  value: sugar,
                  child: Text(sugar),
                );
              }).toList(),
              onChanged: (val) {
                widget.dropDownMenuOnChanged(val);
              },
            ),
            SizedBox(
              height: 0.04 * size.height,
            ),
            Container(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  if (widget.insulinSensitivity == -1 ||
                      widget.carbohydratesRatio == -1) {
                  } else {
                    setState(() {
                      insulinUnits = (widget.carbs / widget.carbohydratesRatio +
                          (widget.bloodSugarLevel - widget.glucoseTarget) /
                              widget.insulinSensitivity);
                    });
                  }
                },
                child: const Text("Calculate",
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
            SizedBox(
              height: 0.02 * size.height,
            ),
            Container(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () async {
                  double? feedBackInsulin =
                      await showInformationDialog(context);
                  if (feedBackInsulin != null) {
                    double effectiveCarbs = (feedBackInsulin -
                            (widget.bloodSugarLevel - widget.glucoseTarget) /
                                widget.insulinSensitivity) *
                        widget.carbohydratesRatio;
                    double feedBackCorrection = effectiveCarbs / widget.carbs;
                    await FoodStatsService(uid: _auth.getUID())
                        .updateFoodFactor(widget.foodNames, widget.mealValue,
                            feedBackCorrection);
                  }
                },
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
