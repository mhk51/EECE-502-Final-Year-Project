import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/food_class.dart';

class RecipeItemInfoArgs {
  FoodClass food;
  List<FoodClass> ingredients;
  RecipeItemInfoArgs(this.food, this.ingredients);
}

class FoodTile extends StatefulWidget {
  final FoodClass food;
  const FoodTile(
      {Key? key,
      required this.food,
      required this.fromenterrecipe,
      required this.ingredients})
      : super(key: key);
  final bool fromenterrecipe;
  final List<FoodClass> ingredients;
  @override
  State<FoodTile> createState() => _FoodTileState();
}

class _FoodTileState extends State<FoodTile> {
  final double fontSize = 11;
  bool addButtonSelected = false;
  bool starButtonSelected = false;

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
            child: Text(widget.food.foodName),
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
                  text: '${widget.food.carbs}',
                  style: TextStyle(color: Colors.blue, fontSize: fontSize),
                ),
                TextSpan(
                  text: ' - Prot: ',
                  style: TextStyle(color: Colors.black, fontSize: fontSize),
                ),
                TextSpan(
                  text: '${widget.food.protein}',
                  style: TextStyle(color: Colors.blue, fontSize: fontSize),
                ),
                TextSpan(
                  text: ' - Fat: ',
                  style: TextStyle(color: Colors.black, fontSize: fontSize),
                ),
                TextSpan(
                  text: '${widget.food.fat}',
                  style: TextStyle(color: Colors.blue, fontSize: fontSize),
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
                    color: addButtonSelected ? Colors.blue : Colors.grey[600],
                    size: 25,
                  ),
                  onPressed: () async {
                    if (widget.fromenterrecipe) {
                      RecipeItemInfoArgs args =
                          RecipeItemInfoArgs(widget.food, widget.ingredients);
                      await Navigator.pushNamed(context, '/RecipeItemInfo',
                          arguments: args);
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
                    color: starButtonSelected ? Colors.amber : Colors.grey[600],
                    size: 25,
                  ),
                  iconSize: 5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
