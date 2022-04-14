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

  Future<void> addRecipeItem(
      FoodClass food, double multiplier, DateTime time) async {
    await userRecipeCollection.add({
      'food': _mapfromFoodClass(food, multiplier),
      'userID': uid,
      'timeAdded': time,
      'recipeName': recipeName,
    });
  }
}