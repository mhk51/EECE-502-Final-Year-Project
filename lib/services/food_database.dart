import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/models/daily_logs_class.dart';
import 'package:flutter_application_1/models/food_class.dart';

class FoodDatabaseService {
  final String uid;
  FoodDatabaseService({required this.uid});

  final CollectionReference userFoodCollection =
      FirebaseFirestore.instance.collection('UserFoodCollection');

  Map<String, dynamic> _foodnamefromFoodClass(
      FoodClass food, int serving, int portion) {
    return {
      'foodName': food.foodName,
      'serving': serving,
      'portion': portion,
    };
  }

  Future<void> updateuserFoodCollection(FoodClass food, int serving,
      int portion, String mealType, DateTime time) async {
    await userFoodCollection.add({
      'foodName': food.foodName,
      'serving': serving,
      'portion': portion,
      'userID': uid,
      'mealType': mealType,
      'timeAdded': time
    });
  }

  //userDataCollection from snapshot
  DailyLogsClass _userDataCollectionfromSnapshot(DocumentSnapshot snapshot) {
    return DailyLogsClass(
        // uid: uid,
        // name: snapshot.get('name'),
        // email: snapshot.get('email'),
        // age: snapshot.get('age'),
        // height: snapshot.get('height'),
        // weight: snapshot.get('weight'),
        // gender: snapshot.get('gender'),
        );
  }

  Stream<DailyLogsClass> get userData {
    return userFoodCollection
        .doc(uid)
        .snapshots()
        .map(_userDataCollectionfromSnapshot);
  }
}
