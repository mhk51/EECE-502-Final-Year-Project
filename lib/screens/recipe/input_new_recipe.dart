import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/custom/constants.dart';
import 'package:flutter_application_1/custom/loading.dart';
import 'package:flutter_application_1/models/food_class.dart';
import 'package:flutter_application_1/screens/daily_log_screen/food_log_tile.dart';
import 'package:flutter_application_1/screens/logging_food/logging_food_screen.dart';
import 'package:flutter_application_1/services/auth.dart';
import 'package:flutter_application_1/services/recipe_database.dart';

class InputNewRecipe extends StatefulWidget {
  const InputNewRecipe({Key? key}) : super(key: key);

  @override
  State<InputNewRecipe> createState() => _InputNewRecipeState();
}

class _InputNewRecipeState extends State<InputNewRecipe> {
  bool saved = false;
  final _auth = AuthService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  RecipeIngredients recipe = RecipeIngredients([]);

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
                    TextFormField(
                      validator: (value) {
                        return value!.isNotEmpty ? null : "Invalid Field";
                      },
                      decoration:
                          const InputDecoration(hintText: "Enter Recipe Name"),
                      controller: _textEditingController,
                    ),
                  ],
                )),
            actions: <Widget>[
              TextButton(
                  onPressed: () async {
                    final uid = _auth.getUID();
                    var carbs = 0.0;
                    var fat = 0.0;
                    var protein = 0.0;
                    var sugar = 0.0;

                    for (int i = 0; i < recipe.ingredients.length; i++) {
                      carbs += recipe.ingredients[i].carbs;
                      fat += recipe.ingredients[i].fat;
                      protein += recipe.ingredients[i].protein;
                      sugar += recipe.ingredients[i].sugar;
                    }
                    // await RecipeDatabaseService(uid: uid,recipeName: recipeName).addRecipe(
                    //     _textEditingController.text,
                    //     carbs,
                    //     protein,
                    //     fat,
                    //     sugar);
                    saved = true;
                    Navigator.of(context).pop();
                  },
                  child: const Text("Save"))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final recipeName = ModalRoute.of(context)!.settings.arguments as String;
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: primaryColor,
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(recipeName),
            ),
            // centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  width: 0.95 * size.width,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: const Text(
                    "Ingredients",
                    style: TextStyle(
                      fontSize: 48,
                      fontFamily: 'Inria Serif',
                    ),
                  ),
                ),
                // Container(
                //   child: Text("Ingredients"),
                // ),
                RecipeIgredientList(
                  ingredientsList: recipe.ingredients,
                  recipeName: recipeName,
                ),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        await Navigator.pushNamed(context, '/NewRecipeSearch',
                            arguments: recipeName);
                        setState(() {});
                      },
                      child: const Text("Add Ingredients",
                          style: TextStyle(
                            fontSize: 28,
                            fontFamily: 'Inria Serif',
                          )),
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all<Size>(
                            const Size(185, 55)),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(primaryColor),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                    ),
                    // ElevatedButton(
                    //   onPressed: () async {
                    //     await Navigator.pushNamed(context, '/NewRecipeSearch',
                    //         arguments: recipeName);
                    //     setState(() {});
                    //   },
                    //   child: const Text("Add Ingredients"),
                    // ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await showInformationDialog(context);
                        if (saved == true) {
                          Navigator.of(context).pop();
                        }

                        // for (int i = 0; i < recipe.ingredients.length; i++) {
                        //   print(recipe.ingredients[i].foodName);
                        // }
                      },
                      child: const Text("Save Recipe",
                          style: TextStyle(
                            fontSize: 28,
                            fontFamily: 'Inria Serif',
                          )),
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all<Size>(
                            const Size(185, 55)),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(primaryColor),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                    ),
                    // ElevatedButton(
                    //   onPressed: () async {
                    //     await showInformationDialog(context);
                    //     if (saved == true) {
                    //       Navigator.of(context).pop();
                    //     }

                    //     // for (int i = 0; i < recipe.ingredients.length; i++) {
                    //     //   print(recipe.ingredients[i].foodName);
                    //     // }
                    //   },
                    //   child: const Text("Save Recipe"),
                    // ),
                  ],
                )
              ],
            ),
          )),
    );
  }
}

class RecipeIgredientList extends StatefulWidget {
  final String recipeName;
  final List<FoodClass> ingredientsList;

  const RecipeIgredientList(
      {Key? key, required this.ingredientsList, required this.recipeName})
      : super(key: key);

  @override
  State<RecipeIgredientList> createState() => _RecipeIgredientListState();
}

class _RecipeIgredientListState extends State<RecipeIgredientList> {
  FoodClass foodClassFromMap(Map<String, dynamic> map) {
    return FoodClass(
        foodName: map['foodName'],
        sugar: map['sugar'],
        carbs: map['carbs'],
        protein: map['protein'],
        fat: map['fat'],
        bloodSugarInc: 0);
  }

  Widget mappingFunction(DocumentSnapshot food) {
    return FoodLogTile(doc: food);
  }

  final _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(1),
      height: 350,
      child: StreamBuilder<List<DocumentSnapshot>>(
          stream: RecipeDatabaseService(
                  uid: _auth.getUID(), recipeName: widget.recipeName)
              .recipeStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active &&
                snapshot.hasData) {
              return ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: snapshot.data!.map(mappingFunction).toList(),
              );
            } else {
              return const Loading();
            }
          }),
    );
  }
}
