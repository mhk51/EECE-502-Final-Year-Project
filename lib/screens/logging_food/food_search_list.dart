import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/models/food_class.dart';
import 'package:flutter_application_1/screens/logging_food/food_tile.dart';
import 'package:flutter_application_1/screens/logging_food/empty_tile.dart';
import 'package:flutter_application_1/services/search_service.dart';

class FoodSearchWidget extends StatefulWidget {
  const FoodSearchWidget(
      {Key? key,
      required this.searchWord,
      required this.fromenterrecipe,
      required this.ingredients,
      required this.bloc})
      : super(key: key);

  final String searchWord;
  final bool fromenterrecipe;
  final List<FoodClass> ingredients;
  final Bloc bloc;

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

  ScrollController controller = ScrollController();

  void _scrollListener() {
    if (controller.offset >= controller.position.maxScrollExtent &&
        !controller.position.outOfRange) {
      widget.bloc.fetchNextMovies();
    }
  }

  @override
  void initState() {
    super.initState();
    widget.bloc.fetchFirstList();
    controller.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: StreamBuilder<List<DocumentSnapshot>>(
            stream: widget.bloc.foodStream,
            builder: (BuildContext context,
                AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return ListView(children: generateEmptyTiles());
                default:
                  return ListView(
                    controller: controller,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    children: snapshot.data!.map((DocumentSnapshot document) {
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
