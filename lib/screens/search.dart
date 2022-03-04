import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String name = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: TextField(
              onChanged: (val) {
                if (val.length > 3) {
                  setState(() {
                    name = val;
                  });
                }
              },
            ),
          ),
          body: StreamBuilder<QuerySnapshot>(
            stream: name != ""
                ? FirebaseFirestore.instance
                    .collection('food')
                    .where("SearchIndex", arrayContains: name)
                    .limit(5)
                    .snapshots()
                : FirebaseFirestore.instance
                    .collection("food")
                    .limit(5)
                    .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) return Text('Error: ${snapshot.error}');
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const Text('Loading...');
                default:
                  return ListView(
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      return ListTile(
                        title: Text(document['Description']),
                      );
                    }).toList(),
                  );
              }
            },
          ),
        ),
      ),
    );
  }
}
