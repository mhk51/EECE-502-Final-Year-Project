import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/models/therapy.dart';

class TherapyDatabaseService {
  final String uid;
  TherapyDatabaseService({required this.uid});

  final CollectionReference userTherapyCollection =
      FirebaseFirestore.instance.collection('UserTherapyCollection');

  Future<void> addUserTherapyCollection() async {
    return await userTherapyCollection.doc(uid).set({
      'hyperglycemia': 11.0,
      'glucoseHigh': 8.0,
      'glucoseTarget': 5.6,
      'glucoseLow': 4.6,
      'hypoglycemia': 3.0,
      'hyperglycemiaAfterMeal': 15.0,
      'glucoseHighAfterMeal': 10.0,
      'glucoseLowAfterMeal': 6.0,
      'breakFastStartTime': '7:00',
      'breakFastEndTime': '10:00',
      'lunchStartTime': '12:00',
      'lunchEndTime': '15:00',
      'dinnerStartTime': '18:00',
      'dinnerEndTime': '20:00',
      'insulinSensitivity': -1.0,
      'carbohydratesRatio': -1.0,
    });
  }

  Future<void> updateUserTherapyCollection(Map<String, dynamic> data) async {
    return await userTherapyCollection.doc(uid).update(data);
  }

  //userDataCollection from snapshot
  Therapy _userDataCollectionfromSnapshot(DocumentSnapshot snapshot) {
    return Therapy(
      uid: uid,
      hyperglycemia: snapshot.get('hyperglycemia'),
      glucoseHigh: snapshot.get('glucoseHigh'),
      glucoseTarget: snapshot.get('glucoseTarget'),
      glucoseLow: snapshot.get('glucoseLow'),
      hypoglycemia: snapshot.get('hypoglycemia'),
      hyperglycemiaAfterMeal: snapshot.get('hyperglycemiaAfterMeal'),
      glucoseHighAfterMeal: snapshot.get('glucoseHighAfterMeal'),
      glucoseLowAfterMeal: snapshot.get('glucoseLowAfterMeal'),
      breakFastStartTime: snapshot.get('breakFastStartTime'),
      breakFastEndTime: snapshot.get('breakFastEndTime'),
      lunchStartTime: snapshot.get('lunchStartTime'),
      lunchEndTime: snapshot.get('lunchEndTime'),
      dinnerStartTime: snapshot.get('dinnerStartTime'),
      dinnerEndTime: snapshot.get('dinnerEndTime'),
      insulinSensitivity: snapshot.get('insulinSensitivity').toDouble(),
      carbohydratesRatio: snapshot.get('carbohydratesRatio').toDouble(),
    );
  }

  Stream<Therapy> get userTherapyData {
    return userTherapyCollection
        .doc(uid)
        .snapshots()
        .map(_userDataCollectionfromSnapshot);
  }

  Future<Map<String, double>> getTherapyParams() async {
    DocumentSnapshot result = await userTherapyCollection.doc(uid).get();
    return {
      'insulinSensitivity': result.get('insulinSensitivity').toDouble(),
      'carbohydratesRatio': result.get('carbohydratesRatio').toDouble(),
      'glucoseTarget': result.get('glucoseTarget'),
    };
  }

  Future<void> updateTherapyParams(
      double insulinSensitivity, double carbohydratesRatio) async {
    userTherapyCollection.doc(uid).update({
      'insulinSensitivity': insulinSensitivity,
      'carbohydratesRatio': carbohydratesRatio
    });
  }
}
