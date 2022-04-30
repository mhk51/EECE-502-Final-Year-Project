import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/models/food_class.dart';

class RecipeDatabaseService {
  final String uid;
  final String recipeName;
  RecipeDatabaseService({required this.uid, required this.recipeName});

  final CollectionReference userRecipeCollection =
      FirebaseFirestore.instance.collection('UserRecipeCollection');

  List<DocumentSnapshot> listfromQuery(QuerySnapshot query) {
    return query.docs;
  }

  Stream<List<DocumentSnapshot>> get recipeStream {
    return userRecipeCollection
        .where('recipeName', isEqualTo: recipeName)
        .snapshots()
        .map(listfromQuery);
  }

  Map<String, dynamic> _mapfromFoodClass(FoodClass food, double multiplier) {
    return {
      'foodName': food.foodName,
      'carbs': (food.carbs * multiplier * 100).round() / 100,
      'fat': (food.fat * multiplier * 100).round() / 100,
      'protein': (food.protein * multiplier * 100).round() / 100,
      'sugar': (food.sugar * multiplier * 100).round() / 100,
    };
  }

  List<String> getUniqueRecipes(List<DocumentSnapshot> docs) {
    List<String> recipeList = [];
    for (int i = 0; i < docs.length; i++) {
      if (recipeList.contains(docs[i].get('recipeName'))) {
        continue;
      } else {
        recipeList.add(docs[i].get('recipeName'));
      }
    }
    return recipeList;
  }

  Future<List<String>> getAllRecipes() async {
    List<DocumentSnapshot> result =
        (await userRecipeCollection.where('userID', isEqualTo: uid).get()).docs;
    return getUniqueRecipes(result);
  }

  Future<void> addRecipeItem(
      FoodClass food, double multiplier, DateTime time) async {
    await userRecipeCollection.add({
      'food': _mapfromFoodClass(food, multiplier),
      'userID': uid,
      'timeAdded': time,
      'recipeName': recipeName,
    });
  }

  Future<bool> checkIfRecipeExists() async {
    QuerySnapshot result = await userRecipeCollection
        .where('recipeName', isEqualTo: recipeName)
        .where('userID', isEqualTo: uid)
        .limit(1)
        .get();
    return result.docs.isNotEmpty;
  }

  Future<void> logAllRecipeItems(String mealType) async {
    final CollectionReference userFoodCollection =
        FirebaseFirestore.instance.collection('UserFoodCollection');
    QuerySnapshot result = await userRecipeCollection
        .where('recipeName', isEqualTo: recipeName)
        .where('userID', isEqualTo: uid)
        .get();
    List<DocumentSnapshot> docs = result.docs;
    for (var element in docs) {
      await userFoodCollection.add({
        'food': element.get('food'),
        'mealType': mealType,
        'timeAdded': DateTime.now(),
        'userID': uid,
      });
    }
  }
}
