import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/food_class.dart';
import 'package:flutter_application_1/screens/logging_food/logging_food_screen.dart';
import 'package:flutter_application_1/screens/recipe/recipe_ingredient_tile.dart';
import 'package:flutter_application_1/services/recipe_database.dart';

import '../../services/auth.dart';

class InputNewRecipe extends StatefulWidget {
  const InputNewRecipe({Key? key}) : super(key: key);

  @override
  State<InputNewRecipe> createState() => _InputNewRecipeState();
}

class _InputNewRecipeState extends State<InputNewRecipe> {
  bool saved = false;
  final _auth = AuthService();
  var delIndex;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Future<void> showInformationDialog(BuildContext context) async {
    var recipe =
        ModalRoute.of(context)!.settings.arguments as RecipeIngredients;
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
                    await RecipeDatabaseService(uid: uid).addRecipe(
                        _textEditingController.text,
                        carbs,
                        protein,
                        fat,
                        sugar);
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
    var recipe =
        ModalRoute.of(context)!.settings.arguments as RecipeIngredients;
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Colors.blue[800],
            title: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("New Recipe"),
            ),
            // centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RecipeIgredientList(ingredientsList: recipe.ingredients),
                Column(
                  children: [
                    // ElevatedButton(
                    //   onPressed: () {
                    //     for (int i = 0; i < recipe.ingredients.length; i++) {
                    //       print(recipe.ingredients[i].foodName);
                    //     }
                    //   },
                    //   child: const Text("Refresh"),
                    // ),
                    ElevatedButton(
                      onPressed: () async {
                        await Navigator.pushNamed(context, '/NewRecipeSearch',
                            arguments: recipe);
                        setState(() {});
                      },
                      child: const Text("Add Ingredients"),
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
                      child: const Text("Save Recipe"),
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }
}

class RecipeIgredientList extends StatefulWidget {
  final List<FoodClass> ingredientsList;

  const RecipeIgredientList({Key? key, required this.ingredientsList})
      : super(key: key);

  @override
  State<RecipeIgredientList> createState() => _RecipeIgredientListState();
}

class _RecipeIgredientListState extends State<RecipeIgredientList> {
  Widget mappingFunction(FoodClass food) {
    return RecipeLogTile(
      food: food,
      foodList: widget.ingredientsList,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      child: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: widget.ingredientsList.map(mappingFunction).toList(),
      ),
    );
  }
}
