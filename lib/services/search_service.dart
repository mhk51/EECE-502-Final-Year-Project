import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

class Bloc {
  List<DocumentSnapshot> documentList = [];

  late StreamController<List<DocumentSnapshot>> foodController;

  Bloc() {
    foodController = StreamController<List<DocumentSnapshot>>();
  }

  Stream<List<DocumentSnapshot>> get foodStream => foodController.stream;

  Future fetchFirstList() async {
    try {
      documentList = (await FirebaseFirestore.instance
              .collection("food")
              .orderBy("Description")
              .limit(6)
              .get())
          .docs;
      foodController.sink.add(documentList);
    } on SocketException {
      foodController.sink
          .addError(const SocketException("No Internet Connection"));
    } catch (e) {
      foodController.sink.addError(e);
    }
  }

  fetchNewSearch(String searchWord) async {
    documentList = (await FirebaseFirestore.instance
            .collection('food')
            .where('SearchIndex', arrayContains: searchWord)
            .limit(6)
            .get())
        .docs;
    foodController.sink.add(documentList);
  }

  fetchNextMovies() async {
    try {
      List<DocumentSnapshot> newDocumentList = (await FirebaseFirestore.instance
              .collection("food")
              .orderBy("Description")
              .startAfterDocument(documentList[documentList.length - 1])
              .limit(6)
              .get())
          .docs;
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
