import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

class Bloc {
  List<DocumentSnapshot> documentList = [];

  late StreamController<List<DocumentSnapshot>?> foodController;
  List<String> searchWords = [];
  Bloc() {
    foodController = StreamController<List<DocumentSnapshot>?>();
  }

  Stream<List<DocumentSnapshot>?> get foodStream => foodController.stream;

  CollectionReference foodDatabaseCollection =
      FirebaseFirestore.instance.collection("foods");

  Future fetchFirstList() async {
    try {
      documentList =
          (await foodDatabaseCollection.orderBy("Description").limit(10).get())
              .docs;
      foodController.sink.add(documentList);
    } on SocketException {
      foodController.sink
          .addError(const SocketException("No Internet Connection"));
    } catch (e) {
      foodController.sink.addError(e);
    }
  }

  Future fetchNewSearch() async {
    foodController.sink.add(null);
    documentList = (await foodDatabaseCollection
            .where('SearchIndex', arrayContainsAny: searchWords)
            .limit(10)
            .get())
        .docs;
    foodController.sink.add(documentList);
  }

  Future fetchNextFood() async {
    try {
      late List<DocumentSnapshot> newDocumentList;
      if (searchWords != []) {
        newDocumentList = (await foodDatabaseCollection
                .where('SearchIndex', arrayContainsAny: searchWords)
                .startAfterDocument(documentList.last)
                .limit(10)
                .get())
            .docs;
      } else {
        newDocumentList = (await foodDatabaseCollection
                .orderBy('Description')
                .startAfterDocument(documentList.last)
                .limit(10)
                .get())
            .docs;
      }
      documentList.addAll(newDocumentList);
      foodController.sink.add(documentList);
    } on SocketException {
      foodController.sink
          .addError(const SocketException("No Internet Connection"));
    } catch (e) {
      foodController.sink.addError(e);
    }
  }

  void dispose() {
    foodController.close();
  }
}
