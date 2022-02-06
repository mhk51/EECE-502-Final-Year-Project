import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/custom/borderBox.dart';
import 'package:flutter_application_1/custom/lineChart.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: size.width,
          height: size.height,
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Home"),
              ),
               Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Blood Sugar Graph:"),
              ),
              lineChart(),


              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  borderBox(
                    padding: EdgeInsets.all(8.0),
                    width: 50,
                    height: 50,
                    child: Icon(
                      Icons.home,
                      color: Colors.black,
                    ),
                  ),
                  borderBox(
                    padding: EdgeInsets.all(8.0),
                    width: 50,
                    height: 50,
                    child: Icon(
                      Icons.list,
                      color: Colors.black,
                    ),
                  ),
                  borderBox(
                    padding: EdgeInsets.all(8.0),
                    width: 50,
                    height: 50,
                    child: Icon(
                      Icons.add,
                      color: Colors.black,
                    ),
                  ),
                  borderBox(
                    padding: EdgeInsets.all(8.0),
                    width: 50,
                    height: 50,
                    child: Icon(
                      Icons.graphic_eq,
                      color: Colors.black,
                    ),
                  ),
                  borderBox(
                    padding: EdgeInsets.all(8.0),
                    width: 50,
                    height: 50,
                    child: Icon(
                      Icons.settings,
                      color: Colors.black,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
