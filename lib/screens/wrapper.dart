import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/Authentication/authenticate.dart';
import 'package:flutter_application_1/screens/home_screen.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context, listen: true);
    // return either the Home or Authenticate widget
    if (user == null) {
      return const Authenticate();
    } else {
      return const HomeScreen();
    }
  }
}

class TestSearch extends StatefulWidget {
  const TestSearch({Key? key}) : super(key: key);

  @override
  State<TestSearch> createState() => _TestSearchState();
}

class _TestSearchState extends State<TestSearch> {
  @override
  Widget build(BuildContext context) {
    ScrollController _controller = ScrollController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Testing'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('food')
            .orderBy('Description')
            .startAfter(['Cheese'])
            .endBefore(['Cheese\uf8ff'])
            // .where("SearchIndex", arrayContains: 'A')
            .limit(10)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Container();
            default:
              return Center(
                child: ListView(
                  controller: _controller,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(document.get('Description')),
                    );
                  }).toList(),
                ),
              );
          }
        },
      ),
    );
  }
}
