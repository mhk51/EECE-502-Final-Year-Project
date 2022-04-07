import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/models/daily_logs_class.dart';
import 'package:flutter_application_1/models/food_class.dart';

class FoodDatabaseService {
  final String uid;
  FoodDatabaseService({required this.uid});

  final CollectionReference userFoodCollection =
      FirebaseFirestore.instance.collection('UserFoodCollection');

  Map<String, dynamic> _foodnamefromFoodClass(FoodClass food) {
    return {
      'foodName': food.foodName,
      'carbs': food.carbs,
      'fat': food.fat,
      'protein': food.protein,
      'sugar': food.sugar,
    };
  }

  // Future<void> deleteFoodLog(DocumentSnapshot doc) async {

  // }

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

  Future<void> updateuserFoodCollection(FoodClass food, int serving,
      int portion, String mealType, DateTime time) async {
    await userFoodCollection.add({
      'food': _foodnamefromFoodClass(food),
      'serving': serving,
      'portion': portion,
      'userID': uid,
      'mealType': mealType,
      'timeAdded': time
    });
  }
}
