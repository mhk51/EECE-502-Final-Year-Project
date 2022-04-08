import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/navdrawer.dart';

class Bolus extends StatefulWidget {
  const Bolus({Key? key}) : super(key: key);

  @override
  State<Bolus> createState() => _BolusState();
}

class _BolusState extends State<Bolus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.indigo[800],
        title: const Text('Bolus Advisor'),
      ),
    );
  }
}
