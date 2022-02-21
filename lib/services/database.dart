import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  // collection reference
  // final CollectionReference food =
  //     FirebaseFirestore.instance.collection('food');
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

  // // brew list from snapshot
  // List<Child> _brewListFromSnapshot(QuerySnapshot snapshot) {
  //   return snapshot.docs.map((doc) {
  //     //print(doc.data);
  //     return Child(
  //       uid: doc.id,
  //       name: doc.get('name') ?? '',
  //       email: doc.get('email'),
  //       age: doc.get('age') ?? 0,
  //       height: doc.get('height') ?? '0',
  //       weight: doc.get('weight') ?? 0,
  //     );
  //     // uid: doc.get('uid')
  //   }).toList();
  // }

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

  // get brews stream
  // Stream<List<Child>> get brews {
  //   return brewCollection.snapshots().map(_brewListFromSnapshot);
  // }

  //get user doc stream

  Stream<Child> get userData {
    return userDataCollection
        .doc(uid)
        .snapshots()
        .map(_userDataCollectionfromSnapshot);
  }
}
