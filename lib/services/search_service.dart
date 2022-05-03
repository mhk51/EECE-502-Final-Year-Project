import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

class Bloc {
  List<DocumentSnapshot> documentList = [];

  late StreamController<List<DocumentSnapshot>> foodController;
  String searchWord = "";
  Bloc() {
    foodController = StreamController<List<DocumentSnapshot>>();
  }

  Stream<List<DocumentSnapshot>> get foodStream => foodController.stream;

  Future fetchFirstList() async {
    try {
      documentList = (await FirebaseFirestore.instance
              .collection("foods")
              .orderBy("Description")
              .limit(10)
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

  fetchNewSearch() async {
    documentList = (await FirebaseFirestore.instance
            .collection('foods')
            .where('SearchIndex', arrayContains: searchWord.toLowerCase())
            .limit(10)
            .get())
        .docs;
    foodController.sink.add(documentList);
  }

  fetchNextMovies() async {
    try {
      List<DocumentSnapshot> newDocumentList = (await FirebaseFirestore.instance
              .collection("foods")
              .where('SearchIndex', arrayContains: searchWord.toLowerCase())
              .startAfterDocument(documentList[documentList.length - 1])
              .limit(10)
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
