import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/models/food_class.dart';

class BarcodeService {
  final CollectionReference barcodeCollection =
      FirebaseFirestore.instance.collection('barcodes');

  FoodClass _foodClassfromSnapshot(QuerySnapshot<Object?> snapshot) {
    QueryDocumentSnapshot data = snapshot.docs.first;
    return FoodClass(
      foodName: data.get('title'),
      sugar: data.get('sugarContent').toDouble(),
      protein: data.get('proteinContent').toDouble(),
      fat: data.get('fatContent').toDouble(),
      carbs: data.get('carbohydrateContent').toDouble(),
      bloodSugarInc: 0,
    );
  }

  Future<FoodClass> barcodeResult(int barcode) async {
    return _foodClassfromSnapshot(await barcodeCollection
        .where('barcode', isEqualTo: barcode)
        .snapshots()
        .first);
  }
}
