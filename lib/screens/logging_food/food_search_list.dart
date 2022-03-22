import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/models/food_class.dart';
import 'package:flutter_application_1/screens/logging_food/food_tile.dart';
import 'package:flutter_application_1/screens/logging_food/empty_tile.dart';

class FoodSearchWidget extends StatefulWidget {
  FoodSearchWidget(
      {Key? key,
      required this.searchWord,
      required this.fromenterrecipe,
      required this.ingredients})
      : super(key: key);

  final String searchWord;
  final bool fromenterrecipe;
  List<FoodClass> ingredients;

  @override
  State<FoodSearchWidget> createState() => _FoodSearchWidgetState();
}

class _FoodSearchWidgetState extends State<FoodSearchWidget> {
  FoodClass documentToFoodClass(DocumentSnapshot document) {
    return FoodClass(
        foodName: document.get("Description"),
        fat: document.get("Saturated Fat") + 0.0,
        sugar: document.get("Sugar Total") + 0.0,
        protein: document.get("Protein") + 0.0,
        carbs: document.get("Carbohydrate") + 0.0,
        bloodSugarInc: 1);
  }

  List<EmptyTile> generateEmptyTiles() {
    List<EmptyTile> list = [];
    for (int i = 0; i < 10; i++) {
      list.add(const EmptyTile());
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: StreamBuilder<QuerySnapshot>(
            stream: widget.searchWord != ""
                ? FirebaseFirestore.instance
                    .collection('food')
                    .where("SearchIndex", arrayContains: widget.searchWord)
                    .limit(5)
                    .snapshots()
                : FirebaseFirestore.instance
                    .collection("food")
                    .limit(5)
                    .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return ListView(children: generateEmptyTiles());
                default:
                  return ListView(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      return FoodTile(
                        food: documentToFoodClass(document),
                        fromenterrecipe: widget.fromenterrecipe,
                        ingredients: widget.ingredients,
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
