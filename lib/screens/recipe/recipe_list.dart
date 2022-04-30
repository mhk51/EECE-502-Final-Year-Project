import 'package:flutter/material.dart';
import 'package:flutter_application_1/custom/loading.dart';
import 'package:flutter_application_1/services/auth.dart';
import 'package:flutter_application_1/services/recipe_database.dart';

class RecipeList extends StatelessWidget {
  const RecipeList({Key? key}) : super(key: key);

  Widget _widgetFromString(String recipe) {
    return Text(recipe);
  }

  @override
  Widget build(BuildContext context) {
    final _auth = AuthService();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe List'),
        backgroundColor: const Color.fromARGB(255, 255, 75, 58),
      ),
      body: FutureBuilder<List<String>>(
          future: RecipeDatabaseService(recipeName: '', uid: _auth.getUID())
              .getAllRecipes(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              List<String> recipes = snapshot.data!;
              return ListView(
                children: recipes.map(_widgetFromString).toList(),
              );
            } else {
              return const Loading();
            }
          }),
    );
  }
}
