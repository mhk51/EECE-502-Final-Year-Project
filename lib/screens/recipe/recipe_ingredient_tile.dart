import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/food_class.dart';

class RecipeLogTile extends StatefulWidget {
  final FoodClass food;
  final List<FoodClass> foodList;
  const RecipeLogTile({Key? key, required this.food, required this.foodList})
      : super(key: key);

  @override
  State<RecipeLogTile> createState() => _RecipeLogTileState();
}

class _RecipeLogTileState extends State<RecipeLogTile> {
  late FoodClass food = widget.food;
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
            onPressed: () {
              for (int i = 0; i < widget.foodList.length; i++) {
                if (widget.foodList[i].foodName == food.foodName) {
                  for (int i = 0; i < widget.foodList.length; i++) {
                    print(widget.foodList[i].foodName);
                  }
                  print("////");
                  print("////");
                  print("////");
                  print(widget.foodList[i].foodName);
                  print(food.foodName + "111");
                  print("////");
                  print("////");
                  print("////");
                  widget.foodList.removeAt(i);
                  for (int i = 0; i < widget.foodList.length; i++) {
                    print(widget.foodList[i].foodName);
                  }
                }
              }
            },
          ),
        ),
      ),
    );
  }
}
