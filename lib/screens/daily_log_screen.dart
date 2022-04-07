import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/custom/loading.dart';
import 'package:flutter_application_1/models/food_class.dart';
import 'package:flutter_application_1/screens/logging_food/food_tile.dart';
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
        body: FutureBuilder<List<DocumentSnapshot>>(
            future: FoodDatabaseService(uid: uid).dailyLogsFoodClass(),
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
              return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Carbs: ${carbs * 100.round() / 100} g"),
                        Text("Protein: ${protein * 100.round() / 100} g"),
                        Text("Fat: ${fat * 100.round() / 100} g"),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
                      child: TodayMealList(
                        mealList: breakfastList,
                        mealType: 'Breakfast',
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
                      child: TodayMealList(
                        mealList: lunchList,
                        mealType: 'Lunch',
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
                      child: TodayMealList(
                        mealList: dinnerList,
                        mealType: 'Dinner',
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
                      child: TodayMealList(
                        mealList: snackList,
                        mealType: 'Snack',
                      ),
                    ),
                  ]);
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

class FoodLogTile extends StatefulWidget {
  final DocumentSnapshot doc;
  const FoodLogTile({Key? key, required this.doc}) : super(key: key);

  @override
  State<FoodLogTile> createState() => _FoodLogTileState();
}

class _FoodLogTileState extends State<FoodLogTile> {
  FoodClass foodClassFromSnapshot(DocumentSnapshot result) {
    Map<String, dynamic> doc = result.get('food') as Map<String, dynamic>;
    return FoodClass(
        foodName: doc['foodName'],
        sugar: doc['sugar'],
        carbs: doc['carbs'],
        protein: doc['protein'],
        fat: doc['fat'],
        bloodSugarInc: 0);
  }

  late FoodClass food = foodClassFromSnapshot(widget.doc);
  final double fontSize = 11;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        color: Colors.grey[200],
        margin: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(food.foodName),
          ),
          // subtitle: Text('Carbs: ${food.carbs}g'),
          subtitle: RichText(
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.start,
            maxLines: 4,
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: 'Carbs: ',
                  style: TextStyle(color: Colors.black, fontSize: fontSize),
                ),
                TextSpan(
                  text: '${food.carbs}',
                  style: TextStyle(color: Colors.blue, fontSize: fontSize),
                ),
                TextSpan(
                  text: ' - Prot: ',
                  style: TextStyle(color: Colors.black, fontSize: fontSize),
                ),
                TextSpan(
                  text: '${food.protein}',
                  style: TextStyle(color: Colors.blue, fontSize: fontSize),
                ),
                TextSpan(
                  text: ' - Fat: ',
                  style: TextStyle(color: Colors.black, fontSize: fontSize),
                ),
                TextSpan(
                  text: '${food.fat}',
                  style: TextStyle(color: Colors.blue, fontSize: fontSize),
                )
              ],
            ),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
