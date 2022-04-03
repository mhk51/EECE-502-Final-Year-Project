import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_application_1/models/food_class.dart';
import 'package:flutter_application_1/screens/navdrawer.dart';

import '../custom/border_box.dart';
import '../services/auth.dart';
// import '../models/daily_logs_class.dart';

class DailyLogScreen extends StatelessWidget {
  DailyLogScreen({Key? key}) : super(key: key);
  final _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    final uid = _auth.getUID();
    return SafeArea(
      child: Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.blue[800],
          title: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Daily Log"),
          ),
          centerTitle: true,
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text("Carbs: 158g"),
                  Text("Protein: 70g"),
                  Text("Fat: 65g"),
                ],
              ),
              Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                child: TodayMealList(
                  uid: uid,
                  mealType: 'Breakfast',
                ),
              ),
              Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                child: TodayMealList(
                  uid: uid,
                  mealType: 'Lunch',
                ),
              ),
              Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                child: TodayMealList(
                  uid: uid,
                  mealType: 'Dinner',
                ),
              ),
              Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                child: TodayMealList(
                  uid: uid,
                  mealType: 'Snack',
                ),
              ),
            ]),
      ),
    );
  }
}

class TodayMealList extends StatelessWidget {
  String mealType;
  TodayMealList({
    Key? key,
    required this.mealType,
    required this.uid,
  }) : super(key: key);

  final String uid;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(mealType),
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("UserFoodCollection")
              .where("userID", isEqualTo: uid)
              .where("mealType", isEqualTo: mealType)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Text("Loading...");
              default:
                return ListView(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      DateTime date = document.get('timeAdded').toDate();
                      print(document.get('mealType'));
                      if (date.isAfter(
                          DateTime.now().subtract(Duration(days: 1)))) {
                        return Text(document.get('foodName'));
                      } else {
                        return Container();
                      }
                    }).toList());
            }
          },
        ),
      ],
    );
  }
}
