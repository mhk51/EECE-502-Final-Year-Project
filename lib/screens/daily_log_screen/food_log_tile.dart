import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/custom/constants.dart';
import 'package:flutter_application_1/models/food_class.dart';
import 'package:flutter_application_1/services/auth.dart';
import 'package:flutter_application_1/services/food_stats_service.dart';

class FoodLogTile extends StatefulWidget {
  final DocumentSnapshot doc;
  final mealType;
  const FoodLogTile({Key? key, required this.doc, required this.mealType})
      : super(key: key);

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
  final _auth = AuthService();
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
                  style: TextStyle(color: primaryColor, fontSize: fontSize),
                ),
                TextSpan(
                  text: ' - Prot: ',
                  style: TextStyle(color: Colors.black, fontSize: fontSize),
                ),
                TextSpan(
                  text: '${food.protein}',
                  style: TextStyle(color: primaryColor, fontSize: fontSize),
                ),
                TextSpan(
                  text: ' - Fat: ',
                  style: TextStyle(color: Colors.black, fontSize: fontSize),
                ),
                TextSpan(
                  text: '${food.fat}',
                  style: TextStyle(color: primaryColor, fontSize: fontSize),
                )
              ],
            ),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              await widget.doc.reference.delete();
              if (widget.mealType != "") {
                await FoodStatsService(uid: _auth.getUID())
                    .decrementCounter(food, widget.mealType);
              }
            },
          ),
        ),
      ),
    );
  }
}
