import 'package:flutter/material.dart';
import 'package:flutter_application_1/custom/loading.dart';
import 'package:flutter_application_1/services/auth.dart';
import 'package:flutter_application_1/services/recipe_database.dart';

class RecipeList extends StatelessWidget {
  const RecipeList({Key? key}) : super(key: key);

  Widget _widgetFromString(String recipe) {
    return Builder(builder: (context) {
      return Container(
        margin: const EdgeInsets.all(10),
        child: ListTile(
          onTap: () async {
            await Navigator.pushNamed(context, '/InputNewRecipe',
                arguments: {'recipeName': recipe, 'Logging': true});
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          contentPadding: const EdgeInsets.all(10),
          tileColor: Colors.grey[200],
          leading: Text(
            recipe,
            style: const TextStyle(fontSize: 28),
          ),
        ),
      );
    });
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
