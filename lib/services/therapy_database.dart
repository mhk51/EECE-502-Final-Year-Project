import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/models/therapy.dart';

class TherapyDatabaseService {
  final String uid;
  TherapyDatabaseService({required this.uid});

  final CollectionReference userTherapyCollection =
      FirebaseFirestore.instance.collection('UserTherapyCollection');

  Future<void> updateUserTherapyCollection(
      double hyperglycemia,
      double glucoseHigh,
      double glocoseTarget,
      double glucoseLow,
      double hypoglycemia,
      double hyperglycemiaAfterMeal,
      double glucoseHighAfterMeal,
      double glucoseLowAfterMeal,
      String breakFastStartTime,
      String breakFastEndTime,
      String lunchStartTime,
      String lunchEndTime,
      String dinnerStartTime,
      String dinnerEndTime,
      double insulinSensitivity,
      double carbohydratesRatio) async {
    return await userTherapyCollection.doc(uid).set({
      'hyperglycemia': hyperglycemia,
      'glucoseHigh': glucoseHigh,
      'glucoseTarget': glocoseTarget,
      'glucoseLow': glucoseLow,
      'hypoglycemia': hypoglycemia,
      'hyperglycemiaAfterMeal': hyperglycemiaAfterMeal,
      'glucoseHighAfterMeal': glucoseHighAfterMeal,
      'glucoseLowAfterMeal': glucoseLowAfterMeal,
      'breakFastStartTime': breakFastStartTime,
      'breakFastEndTime': breakFastEndTime,
      'lunchStartTime': lunchStartTime,
      'lunchEndTime': lunchEndTime,
      'dinnerStartTime': dinnerStartTime,
      'dinnerEndTime': dinnerEndTime,
      'insulinSensitivity': insulinSensitivity,
      'carbohydratesRatio': carbohydratesRatio
    });
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
