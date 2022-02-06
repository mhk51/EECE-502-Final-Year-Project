import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/homeScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'What Do I Eat Demo',
      theme: ThemeData(primaryColor: Colors.white,),
      home: HomeScreen(),
    );
  }
}

