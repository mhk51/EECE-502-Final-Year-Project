import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/custom/border_box.dart';
import 'package:flutter_application_1/custom/line_chart.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Home"),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Blood Sugar Graph:"),
              ),
              const LineChart(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  BorderBox(
                    padding: EdgeInsets.all(8.0),
                    width: 50,
                    height: 50,
                    child: Icon(
                      Icons.home,
                      color: Colors.black,
                    ),
                  ),
                  BorderBox(
                    padding: EdgeInsets.all(8.0),
                    width: 50,
                    height: 50,
                    child: Icon(
                      Icons.list,
                      color: Colors.black,
                    ),
                  ),
                  BorderBox(
                    padding: EdgeInsets.all(8.0),
                    width: 50,
                    height: 50,
                    child: Icon(
                      Icons.add,
                      color: Colors.black,
                    ),
                  ),
                  BorderBox(
                    padding: EdgeInsets.all(8.0),
                    width: 50,
                    height: 50,
                    child: Icon(
                      Icons.graphic_eq,
                      color: Colors.black,
                    ),
                  ),
                  BorderBox(
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
