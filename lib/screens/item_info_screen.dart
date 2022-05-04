import 'package:flutter/material.dart';
import 'package:flutter_application_1/custom/constants.dart';
import 'package:flutter_application_1/models/food_class.dart';
import 'package:flutter_application_1/services/auth.dart';
import 'package:flutter_application_1/services/food_stats_service.dart';
import 'package:flutter_application_1/services/food_database.dart';

class ItemInfoScreen extends StatefulWidget {
  // final FoodClass food;
  const ItemInfoScreen({Key? key}) : super(key: key);

  @override
  State<ItemInfoScreen> createState() => _ItemInfoScreenState();
}

class _ItemInfoScreenState extends State<ItemInfoScreen> {
  List<int> portions = [1, 50, 100, 200, 300, 400, 500];
  List<String> mealType = ["Breakfast", "Lunch", "Dinner", "Snack"];
  String defaultMeal = "Breakfast";
  int defaultPortion = 100;
  double numberofServings = 1.0;
  final _auth = AuthService();
  late TextEditingController foodNameController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final food = ModalRoute.of(context)!.settings.arguments as FoodClass;
    foodNameController = TextEditingController(text: food.foodName);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        // drawer: NavDrawer(),
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: const Padding(
            padding: EdgeInsets.all(8.0),
            // child: Text("Add/Edit Food"),
            child: Text("Add Food"),
          ),
        ),
        body: Scrollbar(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Portion Size:",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  DropdownButtonFormField<int>(
                    value: defaultPortion,
                    decoration: textInputDecoration,
                    items: portions.map((sugar) {
                      return DropdownMenuItem(
                        value: sugar,
                        child: Text('$sugar g'),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => defaultPortion = val!),
                  ),
                ],
              ),

              TextField(
                onChanged: (value) {
                  setState(() {
                    try {
                      numberofServings = double.parse(value);
                    } catch (e) {
                      numberofServings;
                    }
                  });
                },
                decoration: const InputDecoration(
                  hintText: "Number of servings: 1",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.text,
              ),
              //CupertinoSearchTextField(),
              Column(
                children: [
                  const Text(
                    "Nutritional Facts: ",
                    style: TextStyle(color: Colors.black, fontSize: 28),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Table(
                      border: TableBorder.all(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      children: [
                        TableRow(
                          children: [
                            SizedBox(
                              // height: 48,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Food Name: ${food.foodName}",
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 22),
                                ),
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            SizedBox(
                              height: 48,
                              child:
                                  // Text(
                                  //     "Carbs: ${food.carbs * (defaultPortion / 100) * numberofServings}"),
                                  Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RichText(
                                  text: TextSpan(
                                      text: 'Carbs: ',
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 22),
                                      children: [
                                        TextSpan(
                                          text:
                                              '${((food.carbs * (defaultPortion / 100) * numberofServings) * 100).round() / 100}',
                                          style: const TextStyle(
                                              color: primaryColor),
                                        ),
                                        const TextSpan(
                                          text: ' g',
                                        )
                                      ]),
                                ),
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            SizedBox(
                              height: 48,
                              child:
                                  // Text(
                                  //     "Protien: ${food.protein * (defaultPortion / 100) * numberofServings}"),
                                  Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RichText(
                                  text: TextSpan(
                                      text: 'Protien: ',
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 22),
                                      children: [
                                        TextSpan(
                                          text:
                                              '${((food.protein * (defaultPortion / 100) * numberofServings) * 100).round() / 100}',
                                          style: const TextStyle(
                                              color: primaryColor),
                                        ),
                                        const TextSpan(
                                          text: ' g',
                                        )
                                      ]),
                                ),
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            SizedBox(
                              height: 48,
                              child:
                                  // Text(
                                  //     "Fat: ${food.fat * (defaultPortion / 100) * numberofServings}"),
                                  Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RichText(
                                  text: TextSpan(
                                      text: 'Fat: ',
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 22),
                                      children: [
                                        TextSpan(
                                          text:
                                              '${((food.fat * (defaultPortion / 100) * numberofServings) * 100).round() / 100}',
                                          style: const TextStyle(
                                              color: primaryColor),
                                        ),
                                        const TextSpan(
                                          text: ' g',
                                        )
                                      ]),
                                ),
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            SizedBox(
                              height: 48,
                              child:
                                  // Text(
                                  //     "Sugar: ${food.sugar * (defaultPortion / 100) * numberofServings}"),
                                  Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RichText(
                                  text: TextSpan(
                                      text: 'Sugar: ',
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 22),
                                      children: [
                                        TextSpan(
                                          text:
                                              '${((food.sugar * (defaultPortion / 100) * numberofServings) * 100).round() / 100}',
                                          style: const TextStyle(
                                              color: primaryColor),
                                        ),
                                        const TextSpan(
                                          text: ' g',
                                        )
                                      ]),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              DropdownButtonFormField<String>(
                value: defaultMeal,
                decoration: textInputDecoration,
                items: mealType.map((sugar) {
                  return DropdownMenuItem(
                    value: sugar,
                    child: Text(sugar),
                  );
                }).toList(),
                onChanged: (val) => setState(() => defaultMeal = val!),
              ),

              ElevatedButton(
                onPressed: () async {
                  final uid = _auth.getUID();
                  double multiplier =
                      numberofServings * defaultPortion.toDouble() / 100;
                  await FoodDatabaseService(uid: uid).addUserFoodLog(
                      food, multiplier, defaultMeal, DateTime.now());

                  await FoodStatsService(uid: uid)
                      .addUserFoodStatsLog(food, defaultMeal);
                  Navigator.pop(context);
                },
                child: const Text("Log Food",
                    style: TextStyle(
                      fontSize: 28,
                      fontFamily: 'Inria Serif',
                    )),
                style: ButtonStyle(
                  minimumSize:
                      MaterialStateProperty.all<Size>(const Size(314, 70)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(primaryColor),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
