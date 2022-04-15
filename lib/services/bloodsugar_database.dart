import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/custom/line_chart.dart';

class BloodSugarDatabaseService {
  final String uid;
  BloodSugarDatabaseService({required this.uid});

  final CollectionReference userBloodSugarCollection =
      FirebaseFirestore.instance.collection('UserBloodSugarCollection');

  LoggedBSL bslfromDoc(DocumentSnapshot doc) {
    return LoggedBSL(doc.get('BSL'), doc.get('time').toDate());
  }

  List<DocumentSnapshot> listfromQuery(QuerySnapshot query) {
    return query.docs;
  }

  Stream<List<DocumentSnapshot>> get bloodSugarLogStream {
    var now = DateTime.now();
    var lastMidnight = DateTime(now.year, now.month, now.day);
    return userBloodSugarCollection
        .where('userID', isEqualTo: uid)
        .where('time', isGreaterThan: Timestamp.fromDate(lastMidnight))
        .snapshots()
        .map(listfromQuery);
  }

  Future<List<LoggedBSL>> getBSLDocs(String mealType) async {
    var now = DateTime.now();
    var lastMidnight = DateTime(now.year, now.month, now.day);
    return (await userBloodSugarCollection
            .where('userID', isEqualTo: uid)
            .where('mealType', isEqualTo: mealType)
            .where('time', isGreaterThan: Timestamp.fromDate(lastMidnight))
            .get())
        .docs
        .map(bslfromDoc)
        .toList();
  }

  Future<void> addBloodSugarLog(
      double bsl, String mealType, String prepost, DateTime time) async {
    await userBloodSugarCollection.add({
      'BSL': bsl,
      'mealType': mealType,
      'prepost': prepost,
      'userID': uid,
      'time': time
    });
  }
}
