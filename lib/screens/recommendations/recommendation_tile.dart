import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/food_class.dart';

class RecommendationTile extends StatefulWidget {
  final DocumentSnapshot doc;
  const RecommendationTile({Key? key, required this.doc}) : super(key: key);

  @override
  State<RecommendationTile> createState() => _RecommendationTileState();
}

class _RecommendationTileState extends State<RecommendationTile> {
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
          trailing: SizedBox(
            height: 100,
            // width: 100,
            child: IconButton(
              icon: Icon(
                Icons.add_circle,
                color: addButtonSelected ? Colors.blue : Colors.grey[600],
                size: 25,
              ),
              onPressed: () async {
                await Navigator.pushNamed(
                  context,
                  '/ItemInfo',
                  arguments: food,
                );
                setState(() {
                  addButtonSelected = !addButtonSelected;
                });
              },
              iconSize: 5,
            ),
          ),
        ),
      ),
    );
  }
}
