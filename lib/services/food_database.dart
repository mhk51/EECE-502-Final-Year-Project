import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/models/food_class.dart';

class FoodDatabaseService {
  final String uid;
  FoodDatabaseService({required this.uid});

  final CollectionReference userFoodCollection =
      FirebaseFirestore.instance.collection('UserFoodCollection');

  List<DocumentSnapshot> listfromQuery(QuerySnapshot<Object?> doc) {
    return doc.docs;
  }

  Stream<List<DocumentSnapshot>> get dailyLogsFoodClass {
    var now = DateTime.now();
    var lastMidnight = DateTime(now.year, now.month, now.day);
    Stream<List<DocumentSnapshot>> result = userFoodCollection
        .where("userID", isEqualTo: uid)
        .where('timeAdded', isGreaterThan: Timestamp.fromDate(lastMidnight))
        .snapshots()
        .map(listfromQuery);
    return result;
  }

  FoodClass foodClassfromDoc(DocumentSnapshot doc) {
    Map<String, dynamic> food = doc.get('food');
    return FoodClass(
        foodName: food['foodName'],
        sugar: food['sugar'],
        carbs: food['carbs'],
        protein: food['protein'],
        fat: food['fat'],
        bloodSugarInc: 0);
  }

  Future<List<FoodClass>> getFoodLogs(String mealType) async {
    var now = DateTime.now();
    var lastMidnight = DateTime(now.year, now.month, now.day);
    return (await userFoodCollection
            .where("userID", isEqualTo: uid)
            .where('mealType', isEqualTo: mealType)
            .where('timeAdded', isGreaterThan: Timestamp.fromDate(lastMidnight))
            .get())
        .docs
        .map(foodClassfromDoc)
        .toList();
  }

  Map<String, dynamic> _foodnamefromFoodClass(
      FoodClass food, double multiplier) {
    return {
      'foodName': food.foodName,
      'carbs': (food.carbs * multiplier * 100).round() / 100,
      'fat': (food.fat * multiplier * 100).round() / 100,
      'protein': (food.protein * multiplier * 100).round() / 100,
      'sugar': (food.sugar * multiplier * 100).round() / 100,
    };
  }

  Future<void> addUserFoodLog(
      FoodClass food, double multiplier, String mealType, DateTime time) async {
    await userFoodCollection.add({
      'food': _foodnamefromFoodClass(food, multiplier),
      'userID': uid,
      'mealType': mealType,
      'timeAdded': time
    });
  }
}
