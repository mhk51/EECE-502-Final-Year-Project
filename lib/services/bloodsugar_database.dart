import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/models/food_class.dart';

class BloodSugarDatabaseService {
  final String uid;
  BloodSugarDatabaseService({required this.uid});

  final CollectionReference userBloodSugarCollection =
      FirebaseFirestore.instance.collection('UserBloodSugarCollection');

  Map<String, dynamic> _foodnamefromFoodClass(
      FoodClass food, int serving, int portion) {
    return {
      'foodName': food.foodName,
      'serving': serving,
      'portion': portion,
    };
  }

  Future<void> updateuserBloodSugarCollection(
      double bsl, String mealType, String prepost, DateTime time) async {
    await userBloodSugarCollection.add({
      'BSL': bsl,
      'mealType': mealType,
      'prepost': prepost,
      'userID': uid,
      'time': time
    });
  }
}
