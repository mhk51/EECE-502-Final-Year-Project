import 'package:flutter/material.dart';
import 'package:flutter_application_1/custom/constants.dart';
import 'package:flutter_application_1/models/food_class.dart';
import 'package:flutter_application_1/services/auth.dart';
import 'package:flutter_application_1/services/recipe_database.dart';

class RecipeItemInfoScreen extends StatefulWidget {
  // final FoodClass food;
  const RecipeItemInfoScreen({Key? key}) : super(key: key);
  //List<FoodClass> ingredients;

  @override
  State<RecipeItemInfoScreen> createState() => _RecipeItemInfoScreenState();
}

class _RecipeItemInfoScreenState extends State<RecipeItemInfoScreen> {
  List<int> portions = [50, 100, 200, 300, 400, 500];
  int defaultPortion = 100;
  int numberofServings = 1;
  final _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    //final food = ModalRoute.of(context)!.settings.arguments as FoodClass;
    var args = ModalRoute.of(context)!.settings.arguments as Map;
    FoodClass food = args['food'];
    String recipeName = args['recipeName'];
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        // drawer: NavDrawer(),
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
            const Text("Comment on food selected"),
            ElevatedButton(
              // onPressed: () async {
              //   food.carbs =
              //       (food.carbs / 100) * defaultPortion * numberofServings;
              //   food.fat = (food.fat / 100) * defaultPortion * numberofServings;
              //   food.protein =
              //       (food.protein / 100) * defaultPortion * numberofServings;
              //   food.sugar =
              //       (food.sugar / 100) * defaultPortion * numberofServings;
              //   Navigator.pop(context);
              // },
              onPressed: () async {
                final uid = _auth.getUID();
                double multiplier =
                    numberofServings * defaultPortion.toDouble() / 100;
                await RecipeDatabaseService(uid: uid, recipeName: recipeName)
                    .addRecipeItem(food, multiplier, DateTime.now());
                Navigator.pop(context);
              },
              child: const Text("Add Item"),
            ),
          ],
        ),
      ),
    );
  }
}
