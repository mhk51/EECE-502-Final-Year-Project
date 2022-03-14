import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/models/daily_logs_class.dart';
import 'package:flutter_application_1/models/food_class.dart';
import 'package:flutter_application_1/models/user.dart';

class FoodDatabaseService {
  final String uid;
  FoodDatabaseService({required this.uid});

  final CollectionReference userDataCollection =
      FirebaseFirestore.instance.collection('UserFoodCollection');

  String _foodnamefromFoodClass(FoodClass food) {
    return food.foodName;
  }

  Future<void> updateUserDataCollection(DailyLogsClass logsClass) async {
    return await userDataCollection.doc(uid).set({
      'logsClass': logsClass.breakfastList.map(_foodnamefromFoodClass).toList(),
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
