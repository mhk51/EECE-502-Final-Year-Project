import 'package:flutter/material.dart';
import 'package:flutter_application_1/custom/constants.dart';
import 'package:flutter_application_1/screens/logging_food/food_tile.dart';

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
  @override
  Widget build(BuildContext context) {
    //final food = ModalRoute.of(context)!.settings.arguments as FoodClass;
    var args = ModalRoute.of(context)!.settings.arguments as RecipeItemInfoArgs;
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
                            child: Text("Food Name: ${args.food.foodName}"),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          SizedBox(
                            height: 48,
                            child: Text(
                                "Carbs: ${args.food.carbs * (defaultPortion / 100) * numberofServings}"),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          SizedBox(
                            height: 48,
                            child: Text(
                                "Protien: ${args.food.protein * (defaultPortion / 100) * numberofServings}"),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          SizedBox(
                            height: 48,
                            child: Text(
                                "Fat: ${args.food.fat * (defaultPortion / 100) * numberofServings}"),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          SizedBox(
                            height: 48,
                            child: Text(
                                "Sugar: ${args.food.sugar * (defaultPortion / 100) * numberofServings}"),
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
              onPressed: () async {
                //final uid = _auth.getUID();
                // DailyLogsClass logsClass = DailyLogsClass();
                // logsClass.breakfastList.add(food);
                // await FoodDatabaseService(uid: uid).updateUserDataCollection(
                //     food, numberofServings, defaultPortion);
                args.ingredients.add(args.food);
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
