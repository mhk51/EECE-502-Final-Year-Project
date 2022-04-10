import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/custom/line_chart.dart';
import 'package:flutter_application_1/models/food_class.dart';

class RecipeDatabaseService {
  final String uid;
  RecipeDatabaseService({required this.uid});

  final CollectionReference userRecipeCollection =
      FirebaseFirestore.instance.collection('UserRecipeCollection');

  LoggedBSL bslfromDoc(DocumentSnapshot doc) {
    return LoggedBSL(doc.get('BSL'), doc.get('time'));
  }

  List<DocumentSnapshot> listfromQuery(QuerySnapshot query) {
    return query.docs;
  }

  Stream<List<DocumentSnapshot>> get recipeStream {
    return userRecipeCollection.snapshots().map(listfromQuery);
  }

  Future<void> addRecipe(String recipeName, double carbs, double protein,
      double fat, double sugar) async {
    await userRecipeCollection.add({
      'recipeName': recipeName,
      'carbs': carbs,
      'protein': protein,
      'fat': fat,
      'sugar': sugar,
      'userID': uid,
    });
  }
}
