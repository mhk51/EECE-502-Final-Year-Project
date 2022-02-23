import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  final CollectionReference userDataCollection =
      FirebaseFirestore.instance.collection('UserDataCollection');

  Future<void> updateUserDataCollection(String name, String email, int height,
      int age, int weight, String gender) async {
    return await userDataCollection.doc(uid).set({
      'name': name,
      'email': email,
      'age': age,
      'height': height,
      'weight': weight,
      'gender': gender,
    });
  }

  //userDataCollection from snapshot
  Child _userDataCollectionfromSnapshot(DocumentSnapshot snapshot) {
    return Child(
      uid: uid,
      name: snapshot.get('name'),
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
