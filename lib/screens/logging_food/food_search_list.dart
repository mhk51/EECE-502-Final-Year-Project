import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/models/food_class.dart';
import 'package:flutter_application_1/screens/logging_food/food_tile.dart';
import 'package:flutter_application_1/screens/logging_food/empty_tile.dart';
import 'package:flutter_application_1/services/search_service.dart';

class FoodSearchWidget extends StatefulWidget {
  final String recipeName;
  const FoodSearchWidget(
      {Key? key,
      required this.searchWord,
      required this.recipeName,
      required this.bloc})
      : super(key: key);

  final String searchWord;
  // final bool fromenterrecipe;
  // final List<FoodClass> ingredients;
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

  void _scrollListener() async {
    if (controller.offset >= controller.position.maxScrollExtent &&
        !controller.position.outOfRange) {
      await widget.bloc.fetchNextMovies();
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
      child: StreamBuilder<List<DocumentSnapshot>?>(
        stream: widget.bloc.foodStream,
        builder: (BuildContext context,
            AsyncSnapshot<List<DocumentSnapshot>?> snapshot) {
          if (snapshot.connectionState == ConnectionState.active &&
              snapshot.hasData &&
              snapshot.data != null) {
            List<FoodClass> list =
                snapshot.data!.map(documentToFoodClass).toList();
            return Scrollbar(
              controller: controller,
              thickness: 5,
              radius: const Radius.circular(90),
              interactive: true,
              showTrackOnHover: true,
              hoverThickness: 10,
              trackVisibility: true,
              isAlwaysShown: true,
              child: ListView.separated(
                controller: controller,
                itemCount: list.length,
                itemBuilder: (context, index) {
                  if (widget.recipeName == '') {
                    return FoodTile(
                      food: list[index],
                      recipeName: '',
                    );
                  } else {
                    return FoodTile(
                        food: list[index], recipeName: widget.recipeName);
                  }
                },
                separatorBuilder: (context, index) {
                  return const Padding(
                    padding: EdgeInsets.only(right: 5),
                    child: Divider(
                      height: 1,
                      color: Colors.black,
                      thickness: 0.75,
                    ),
                  );
                },
                physics: const ScrollPhysics(parent: BouncingScrollPhysics()),
                padding: const EdgeInsets.all(0),
              ),
            );
          } else {
            return ListView(children: generateEmptyTiles());
          }
        },
      ),
    );
  }
}
