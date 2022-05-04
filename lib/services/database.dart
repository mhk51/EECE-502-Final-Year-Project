import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  final CollectionReference userDataCollection =
      FirebaseFirestore.instance.collection('UserDataCollection');

  Future<void> addUserDataCollection(String firstname, String lastname,
      String email, int height, int age, int weight, String gender) async {
    return await userDataCollection.doc(uid).set({
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'age': age,
      'height': height,
      'weight': weight,
      'gender': gender,
    });
  }

  Future<void> updateUserDataCollection(Map<String, dynamic> data) async {
    return await userDataCollection.doc(uid).update(data);
  }

  //userDataCollection from snapshot
  Child _userDataCollectionfromSnapshot(DocumentSnapshot snapshot) {
    return Child(
      uid: uid,
      firstName: snapshot.get('firstname'),
      lastName: snapshot.get('lastname'),
      email: snapshot.get('email'),
      age: snapshot.get('age'),
      height: snapshot.get('height'),
      weight: snapshot.get('weight'),
      gender: snapshot.get('gender'),
    );
  }

  Stream<Child> get userData {
    return userDataCollection
        .doc(uid)
        .snapshots()
        .map(_userDataCollectionfromSnapshot);
  }
}
