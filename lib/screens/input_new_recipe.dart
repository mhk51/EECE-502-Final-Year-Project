import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/screens/logging_food/logging_food_screen.dart';

class inputNewRecipe extends StatefulWidget {
  const inputNewRecipe({Key? key}) : super(key: key);

  @override
  State<inputNewRecipe> createState() => _inputNewRecipeState();
}

class _inputNewRecipeState extends State<inputNewRecipe> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
                  onPressed: () {
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
        ModalRoute.of(context)!.settings.arguments as recipeIngredients;
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
          body: Center(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 550,
                      child: ListView.builder(
                          padding: const EdgeInsets.all(8),
                          itemCount: recipe.ingredients.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              height: 50,
                              margin: EdgeInsets.all(2),
                              color: Colors.blue,
                              child: Center(
                                  child: Text(
                                '${recipe.ingredients[index].foodName}',
                                style: TextStyle(fontSize: 18),
                              )),
                            );
                          }),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {});
                      },
                      child: const Text("Refresh"),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await Navigator.pushNamed(context, '/NewRecipeSearch',
                            arguments: recipe);
                      },
                      child: const Text("Add Ingredients"),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await showInformationDialog(context);

                        // for (int i = 0; i < recipe.ingredients.length; i++) {
                        //   print(recipe.ingredients[i].foodName);
                        // }
                      },
                      child: const Text("Save Recipe"),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
