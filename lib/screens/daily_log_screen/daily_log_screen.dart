import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/custom/constants.dart';
import 'package:flutter_application_1/custom/loading.dart';
import 'package:flutter_application_1/screens/daily_log_screen/food_log_tile.dart';
import 'package:flutter_application_1/screens/navdrawer.dart';
import 'package:flutter_application_1/services/auth.dart';
import 'package:flutter_application_1/services/food_database.dart';

class DailyLogScreen extends StatefulWidget {
  const DailyLogScreen({Key? key}) : super(key: key);

  @override
  State<DailyLogScreen> createState() => _DailyLogScreenState();
}

class _DailyLogScreenState extends State<DailyLogScreen> {
  final _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final uid = _auth.getUID();
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Daily Log"),
          ),
          centerTitle: true,
        ),
        body: StreamBuilder<List<DocumentSnapshot>>(
            stream: FoodDatabaseService(uid: uid).dailyLogsFoodClass,
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
                if (snapshot.data![i].get('mealType') == 'Breakfast') {
                  breakfastList.add(snapshot.data![i]);
                } else if (snapshot.data![i].get('mealType') == 'Lunch') {
                  lunchList.add(snapshot.data![i]);
                } else if (snapshot.data![i].get('mealType') == 'Dinner') {
                  dinnerList.add(snapshot.data![i]);
                } else if (snapshot.data![i].get('mealType') == 'Snack') {
                  snackList.add(snapshot.data![i]);
                }
                carbs += snapshot.data![i].get('food')['carbs'];
                fat += snapshot.data![i].get('food')['fat'];
                protein += snapshot.data![i].get('food')['protein'];
              }
              return SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 0.03 * size.height,
                          ),
                          Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                color: Colors.white,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10))),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Total Daily Intake: ",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 28),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                        text: 'Carbs: ',
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 22),
                                        children: [
                                          TextSpan(
                                            text:
                                                '${(carbs * 100).round() / 100}',
                                            style: const TextStyle(
                                                color: primaryColor),
                                          ),
                                          const TextSpan(
                                            text: ' g',
                                          )
                                        ]),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                        text: 'Protein: ',
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 22),
                                        children: [
                                          TextSpan(
                                            text:
                                                '${(protein * 100).round() / 100}',
                                            style: const TextStyle(
                                                color: primaryColor),
                                          ),
                                          const TextSpan(
                                            text: ' g',
                                          )
                                        ]),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                        text: 'Fat: ',
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 22),
                                        children: [
                                          TextSpan(
                                            text:
                                                '${(fat * 100).round() / 100}',
                                            style: const TextStyle(
                                                color: primaryColor),
                                          ),
                                          const TextSpan(
                                            text: ' g',
                                          )
                                        ]),
                                  )
                                ]),
                          ),
                        ],
                      ),
                      Container(
                        // decoration: BoxDecoration(
                        //     border: Border.all(color: Colors.black)),
                        child: TodayMealList(
                          mealList: breakfastList,
                          mealType: 'Breakfast',
                        ),
                      ),
                      Container(
                        // decoration: BoxDecoration(
                        //     border: Border.all(color: Colors.black)),
                        child: TodayMealList(
                          mealList: lunchList,
                          mealType: 'Lunch',
                        ),
                      ),
                      Container(
                        // decoration: BoxDecoration(
                        //     border: Border.all(color: Colors.black)),
                        child: TodayMealList(
                          mealList: dinnerList,
                          mealType: 'Dinner',
                        ),
                      ),
                      Container(
                        // decoration: BoxDecoration(
                        //     border: Border.all(color: Colors.black)),
                        child: TodayMealList(
                          mealList: snackList,
                          mealType: 'Snack',
                        ),
                      ),
                    ]),
              );
            }),
      ),
    );
  }
}

class TodayMealList extends StatefulWidget {
  final List<DocumentSnapshot> mealList;
  final String mealType;
  const TodayMealList(
      {Key? key, required this.mealList, required this.mealType})
      : super(key: key);

  @override
  State<TodayMealList> createState() => _TodayMealListState();
}

class _TodayMealListState extends State<TodayMealList> {
  Widget mappingFunction(DocumentSnapshot doc) {
    return FoodLogTile(doc: doc);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: 0.02 * size.height,
        ),
        Text(
          widget.mealType,
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
        ),
        ListView(
          physics: const NeverScrollableScrollPhysics(),
          // scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: widget.mealList.map(mappingFunction).toList(),
        ),
      ],
    );
  }
}
