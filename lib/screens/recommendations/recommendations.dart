import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/recommendations/recommendation_tile.dart';
import 'package:flutter_application_1/services/food_stats_service.dart';

import '../../custom/loading.dart';
import '../../services/auth.dart';

class Recommendations extends StatefulWidget {
  const Recommendations({Key? key}) : super(key: key);

  @override
  State<Recommendations> createState() => _RecommendationsState();
}

class _RecommendationsState extends State<Recommendations> {
  final _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    final uid = _auth.getUID();
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue[800],
            title: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Recommendations"),
            ),
            centerTitle: true,
          ),
          body: StreamBuilder<List<DocumentSnapshot>>(
              stream: FoodStatsService(uid: uid).recommendedFoodClass,
              builder: (context, snapshot) {
                double carbs = 0;
                double protein = 0;
                double fat = 0;
                List<DocumentSnapshot> breakfastList = [];
                List<DocumentSnapshot> lunchList = [];
                List<DocumentSnapshot> dinnerList = [];
                List<DocumentSnapshot> snackList = [];

                if (!snapshot.hasData) {
                  return const Loading();
                }
                for (int i = 0; i < snapshot.data!.length; i++) {
                  if (snapshot.data![i].get('Breakfast') > 1) {
                    breakfastList.add(snapshot.data![i]);
                  } else if (snapshot.data![i].get('Lunch') > 1) {
                    lunchList.add(snapshot.data![i]);
                  } else if (snapshot.data![i].get('Dinner') > 1) {
                    dinnerList.add(snapshot.data![i]);
                  } else if (snapshot.data![i].get('Snack') > 1) {
                    snackList.add(snapshot.data![i]);
                  }
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
                      child: RecommendationList(
                        mealList: breakfastList,
                        mealType: 'Breakfast Recommendations',
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
                      child: RecommendationList(
                        mealList: lunchList,
                        mealType: 'Lunch Recommendations',
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
                      child: RecommendationList(
                        mealList: dinnerList,
                        mealType: 'Dinner Recommendations',
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
                      child: RecommendationList(
                        mealList: snackList,
                        mealType: 'Snack Recommendations',
                      ),
                    ),
                  ],
                );
              })),
    );
  }
}

class RecommendationList extends StatefulWidget {
  final List<DocumentSnapshot> mealList;
  final String mealType;
  const RecommendationList(
      {Key? key, required this.mealList, required this.mealType})
      : super(key: key);

  @override
  State<RecommendationList> createState() => _RecommendationListState();
}

class _RecommendationListState extends State<RecommendationList> {
  Widget mappingFunction(DocumentSnapshot doc) {
    return RecommendationTile(doc: doc);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(widget.mealType),
        ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: widget.mealList.map(mappingFunction).toList(),
        ),
      ],
    );
  }
}
