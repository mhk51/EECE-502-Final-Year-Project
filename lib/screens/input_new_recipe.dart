import 'package:flutter/material.dart';

class inputNewRecipe extends StatefulWidget {
  const inputNewRecipe({Key? key}) : super(key: key);

  @override
  State<inputNewRecipe> createState() => _inputNewRecipeState();
}

class _inputNewRecipeState extends State<inputNewRecipe> {
  @override
  Widget build(BuildContext context) {
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
                    await Navigator.pushNamed(
                      context,
                      '/NewRecipeSearch',
                    );
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
