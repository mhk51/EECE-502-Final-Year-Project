import 'package:flutter/material.dart';
import 'package:flutter_application_1/custom/constants.dart';
import 'package:flutter_application_1/models/food_class.dart';

class RecipeItemInfoArgs {
  FoodClass food;
  List<FoodClass> ingredients;
  RecipeItemInfoArgs(this.food, this.ingredients);
}

class FoodTile extends StatefulWidget {
  final FoodClass food;
  final String recipeName;
  const FoodTile({
    Key? key,
    required this.food,
    required this.recipeName,
    // required this.ingredients
  }) : super(key: key);
  // final List<FoodClass> ingredients;
  @override
  State<FoodTile> createState() => _FoodTileState();
}

class _FoodTileState extends State<FoodTile> {
  final double fontSize = 11;
  bool addButtonSelected = false;
  bool starButtonSelected = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      style: ListTileStyle.drawer,
      title: Text(widget.food.foodName),
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
              text: '${widget.food.carbs}',
              style: TextStyle(color: primaryColor, fontSize: fontSize),
            ),
            TextSpan(
              text: ' - Prot: ',
              style: TextStyle(color: Colors.black, fontSize: fontSize),
            ),
            TextSpan(
              text: '${widget.food.protein}',
              style: TextStyle(color: primaryColor, fontSize: fontSize),
            ),
            TextSpan(
              text: ' - Fat: ',
              style: TextStyle(color: Colors.black, fontSize: fontSize),
            ),
            TextSpan(
              text: '${widget.food.fat}',
              style: TextStyle(color: primaryColor, fontSize: fontSize),
            )
          ],
        ),
      ),
      trailing: SizedBox(
        height: 100,
        width: 100,
        child: Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.add_circle,
                color: addButtonSelected ? primaryColor : Colors.grey[600],
                size: 25,
              ),
              onPressed: () async {
                if (widget.recipeName != "") {
                  await Navigator.pushNamed(context, '/RecipeItemInfo',
                      arguments: {
                        'food': widget.food,
                        'recipeName': widget.recipeName
                      });
                  setState(() {
                    addButtonSelected = !addButtonSelected;
                  });
                } else {
                  await Navigator.pushNamed(
                    context,
                    '/ItemInfo',
                    arguments: widget.food,
                  );
                  setState(() {
                    addButtonSelected = !addButtonSelected;
                  });
                }
              },
              iconSize: 5,
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  starButtonSelected = !starButtonSelected;
                });
              },
              icon: Icon(
                Icons.star,
                color: starButtonSelected ? primaryColor : Colors.grey[600],
                size: 25,
              ),
              iconSize: 5,
            ),
          ],
        ),
      ),
    );
  }
}
