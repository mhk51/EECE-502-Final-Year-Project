import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/models/daily_logs_class.dart';
import 'package:flutter_application_1/models/food_class.dart';

class FoodDatabaseService {
  final String uid;
  FoodDatabaseService({required this.uid});

  final CollectionReference userDataCollection =
      FirebaseFirestore.instance.collection('UserFoodCollection');

  Map<String, dynamic> _foodnamefromFoodClass(
      FoodClass food, int serving, int portion) {
    return {
      'foodName': food.foodName,
      'serving': serving,
      'portion': portion,
    };
  }

  Future<void> updateUserDataCollection(
      FoodClass food, int serving, int portion) async {
    DocumentSnapshot a = await userDataCollection.doc(uid).get();
    List<dynamic> list = a.get('logsClass');
    list.add({
      'foodName': food.foodName,
      'serving': serving,
      'portion': portion,
    });
    return await userDataCollection.doc(uid).set({
      // 'logsClass': logsClass.breakfastList
      //     .map((food) => _foodnamefromFoodClass(food, serving, portion))
      //     .toList(),
      'logsClass': list
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
    return userDataCollection
        .doc(uid)
        .snapshots()
        .map(_userDataCollectionfromSnapshot);
  }
}
