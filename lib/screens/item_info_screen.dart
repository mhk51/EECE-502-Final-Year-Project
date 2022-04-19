import 'package:flutter/material.dart';
import 'package:flutter_application_1/custom/constants.dart';
import 'package:flutter_application_1/models/food_class.dart';
import 'package:flutter_application_1/services/auth.dart';
import 'package:flutter_application_1/services/foodStats.dart';
import 'package:flutter_application_1/services/food_database.dart';

class ItemInfoScreen extends StatefulWidget {
  // final FoodClass food;
  const ItemInfoScreen({Key? key}) : super(key: key);

  @override
  State<ItemInfoScreen> createState() => _ItemInfoScreenState();
}

class _ItemInfoScreenState extends State<ItemInfoScreen> {
  List<int> portions = [50, 100, 200, 300, 400, 500];
  List<String> mealType = ["Breakfast", "Lunch", "Dinner", "Snack"];
  String defaultMeal = "Breakfast";
  int defaultPortion = 100;
  int numberofServings = 1;
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
          backgroundColor: Colors.blue[800],
          title: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Add/Edit Food"),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.delete),
              iconSize: 28,
            ),
            const SizedBox(
              width: 10,
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.save),
              iconSize: 28,
            )
          ],
        ),
        body: Scrollbar(
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                "Item Info:",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.grey[200],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                            child: Text('Food Name'),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: TextField(
                              minLines: 3,
                              maxLines: 3,
                              controller: foodNameController,
                              decoration: InputDecoration(
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1.5,
                                    color: Colors.grey[500]!,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1.5,
                                    color: Colors.grey[500]!,
                                  ),
                                ),
                                fillColor: Colors.white,
                              ),
                              onChanged: (val) {},
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add_circle),
                label: const Text('Add photo'),
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
              TextField(
                onChanged: (value) {
                  setState(() {
                    try {
                      numberofServings = int.parse(value);
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
                  const Text("Nutritional Facts: "),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Table(
                      border: TableBorder.all(),
                      children: [
                        TableRow(
                          children: [
                            SizedBox(
                              height: 48,
                              child: Text("Food Name: ${food.foodName}"),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            SizedBox(
                              height: 48,
                              child: Text(
                                  "Carbs: ${food.carbs * (defaultPortion / 100) * numberofServings}"),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            SizedBox(
                              height: 48,
                              child: Text(
                                  "Protien: ${food.protein * (defaultPortion / 100) * numberofServings}"),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            SizedBox(
                              height: 48,
                              child: Text(
                                  "Fat: ${food.fat * (defaultPortion / 100) * numberofServings}"),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            SizedBox(
                              height: 48,
                              child: Text(
                                  "Sugar: ${food.sugar * (defaultPortion / 100) * numberofServings}"),
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
              const Text("Comment on food selected"),
              ElevatedButton(
                onPressed: () async {
                  final uid = _auth.getUID();
                  double multiplier =
                      numberofServings * defaultPortion.toDouble() / 100;
                  await FoodDatabaseService(uid: uid).addUserFoodLog(
                      food, multiplier, defaultMeal, DateTime.now());

                  await FoodStatsService(uid: uid)
                      .addUserFoodStatsLog(food, defaultMeal, 10);
                  Navigator.pop(context);
                },
                child: const Text("Log Food"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
