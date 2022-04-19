import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/models/food_class.dart';

class FoodStatsService {
  final String uid;
  late CollectionReference userFoodStatsCollection;

  FoodStatsService({required this.uid}) {
    assignCollection(uid);
  }

  void assignCollection(uid) {
    userFoodStatsCollection = FirebaseFirestore.instance.collection(uid);
  }

  List<DocumentSnapshot> listfromQuery(QuerySnapshot<Object?> doc) {
    return doc.docs;
  }

  // Stream<List<DocumentSnapshot>> get dailyLogsFoodClass {
  //   var now = DateTime.now();
  //   var lastMidnight = DateTime(now.year, now.month, now.day);
  //   Stream<List<DocumentSnapshot>> result = userFoodStatsCollection
  //       .where("userID", isEqualTo: uid)
  //       .where('timeAdded', isGreaterThan: Timestamp.fromDate(lastMidnight))
  //       .snapshots()
  //       .map(listfromQuery);
  //   return result;
  // }

  // FoodClass foodClassfromDoc(DocumentSnapshot doc) {
  //   Map<String, dynamic> food = doc.get('food');
  //   return FoodClass(
  //       foodName: food['foodName'],
  //       sugar: food['sugar'],
  //       carbs: food['carbs'],
  //       protein: food['protein'],
  //       fat: food['fat'],
  //       bloodSugarInc: 0);
  // }

  // Future<List<FoodClass>> getFoodLogs(String mealType) async {
  //   var now = DateTime.now();
  //   var lastMidnight = DateTime(now.year, now.month, now.day);
  //   return (await userFoodStatsCollection
  //           .where("userID", isEqualTo: uid)
  //           .where('mealType', isEqualTo: mealType)
  //           .where('timeAdded', isGreaterThan: Timestamp.fromDate(lastMidnight))
  //           .get())
  //       .docs
  //       .map(foodClassfromDoc)
  //       .toList();
  // }

  // Map<String, dynamic> _foodnamefromFoodClass(
  //     FoodClass food, double multiplier) {
  //   return {
  //     'foodName': food.foodName,
  //     'carbs': (food.carbs * multiplier * 100).round() / 100,
  //     'fat': (food.fat * multiplier * 100).round() / 100,
  //     'protein': (food.protein * multiplier * 100).round() / 100,
  //     'sugar': (food.sugar * multiplier * 100).round() / 100,
  //   };
  // }

  Stream<List<DocumentSnapshot>> get recommendedFoodClass {
    Stream<List<DocumentSnapshot>> result = userFoodStatsCollection
        .where("count", isGreaterThan: 1)
        .snapshots()
        .map(listfromQuery);
    return result;
  }

  Map<String, dynamic> _foodnamefromFoodClass(FoodClass food) {
    return {
      'foodName': food.foodName,
      'carbs': food.carbs,
      'fat': food.fat,
      'protein': food.protein,
      'sugar': food.sugar,
    };
  }

  Future<void> addUserFoodStatsLog(
      FoodClass food, String mealType, double score) async {
    DocumentSnapshot entry =
        await userFoodStatsCollection.doc(food.foodName).get();
    bool exists = entry.exists;

    int breakfastCount = 0;
    int lunchCount = 0;
    int dinnerCount = 0;
    int snackCount = 0;
    if (mealType == "Breakfast") {
      breakfastCount = 1;
    } else if (mealType == "Lunch") {
      lunchCount = 1;
    } else if (mealType == "Dinner") {
      dinnerCount = 1;
    } else if (mealType == "Snack") {
      snackCount = 1;
    }
    if (exists == false) {
      await userFoodStatsCollection.doc(food.foodName).set({
        'food': _foodnamefromFoodClass(food),
        'count': 1,
        'Breakfast': breakfastCount,
        'Lunch': lunchCount,
        'Dinner': dinnerCount,
        'Snack': snackCount,
        'score': score
      });
    } else {
      int count = entry.get("count");
      int currBreakfastCount = entry.get("Breakfast");
      int currLunchCount = entry.get("Lunch");
      int currDinnerCount = entry.get("Dinner");
      int currSnackCount = entry.get("Snack");

      await userFoodStatsCollection
          .doc(food.foodName)
          .update({'count': count + 1});

      if (mealType == "Breakfast") {
        await userFoodStatsCollection
            .doc(food.foodName)
            .update({'Breakfast': currBreakfastCount + 1});
      } else if (mealType == "Lunch") {
        await userFoodStatsCollection
            .doc(food.foodName)
            .update({'Lunch': currLunchCount + 1});
      } else if (mealType == "Dinner") {
        await userFoodStatsCollection
            .doc(food.foodName)
            .update({'Dinner': currDinnerCount + 1});
      } else if (mealType == "Snack") {
        await userFoodStatsCollection
            .doc(food.foodName)
            .update({'Snack': currSnackCount + 1});
      }
    }
    // userFoodStatsCollection.doc().set(data)
  }
}
