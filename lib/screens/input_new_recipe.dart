import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/logging_food/logging_food_screen.dart';

class inputNewRecipe extends StatefulWidget {
  const inputNewRecipe({Key? key}) : super(key: key);

  @override
  State<inputNewRecipe> createState() => _inputNewRecipeState();
}

class _inputNewRecipeState extends State<inputNewRecipe> {
  @override
  Widget build(BuildContext context) {
    var recipe =
        ModalRoute.of(context)!.settings.arguments as recipeIngredients;
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue[800],
            title: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("New Recipe"),
            ),
            // centerTitle: true,
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await Navigator.pushNamed(context, '/NewRecipeSearch',
                        arguments: recipe);
                  },
                  child: const Text("Add Ingredients"),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Save Recipe"),
                ),
              ],
            ),
          )),
    );
  }
}
