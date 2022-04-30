import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/custom/constants.dart';
import 'package:flutter_application_1/custom/line_chart.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_application_1/screens/navdrawer.dart';
import 'package:flutter_application_1/services/bloodsugar_database.dart';
import 'package:provider/provider.dart';

import '../services/auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = AuthService();
  List<String> mealType = ["Breakfast", "Lunch", "Dinner", "Snack"];
  List<String> prepost = ["Before Meal", "After Meal"];
  String defaultMeal = "Breakfast";
  String defaultPrepost = "Before Meal";
  Color primaryColor = const Color.fromARGB(255, 255, 75, 58);
  Color backgroundColor = const Color.fromARGB(242, 242, 242, 242);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Future<void> showInformationDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          final TextEditingController _textEditingController =
              TextEditingController();
          return AlertDialog(
            content: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    validator: (value) {
                      return value!.isNotEmpty ? null : "Invalid Field";
                    },
                    decoration:
                        const InputDecoration(hintText: "Enter Sugar Level"),
                    controller: _textEditingController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                  DropdownButtonFormField<String>(
                    value: defaultMeal,
                    decoration: textInputDecoration,
                    items: mealType.map((sugar) {
                      return DropdownMenuItem(
                        value: sugar,
                        child: Text(sugar),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => defaultMeal = val!),
                  ),
                  DropdownButtonFormField<String>(
                    value: defaultPrepost,
                    decoration: textInputDecoration,
                    items: prepost.map((sugar) {
                      return DropdownMenuItem(
                        value: sugar,
                        child: Text(sugar),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => defaultPrepost = val!),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // TimeOfDay now = TimeOfDay.now();
                    LoggedBSL currentBSL = LoggedBSL(
                        double.parse(_textEditingController.text),
                        DateTime.now());
                    LoggedBSL.chartData.add(currentBSL);
                    final uid = _auth.getUID();
                    await BloodSugarDatabaseService(uid: uid).addBloodSugarLog(
                        currentBSL.level,
                        defaultMeal,
                        defaultPrepost,
                        DateTime.now());
                    Navigator.of(context).pop();
                  }
                },
                child: Text(
                  "Submit",
                  style: TextStyle(color: primaryColor),
                ),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: backgroundColor,
        appBar: AppBar(
          title: const Text("Home"),
          backgroundColor: primaryColor,
          actions: [
            TextButton.icon(
              onPressed: () {
                // _auth.signOut();
                Navigator.pushReplacementNamed(context, "/LoggingFood");
              },
              icon: const Icon(
                Icons.restaurant_outlined,
                color: Colors.white,
              ),
              label: const Text(
                "Search",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
        drawer: NavDrawer(),
        body: SingleChildScrollView(
          child: SizedBox(
            width: size.width,
            height: size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  width: 0.95 * size.width,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Text('Welcome\n${user!.name}',
                      style: const TextStyle(
                        fontSize: 40,
                        fontFamily: 'Inria Serif',
                      )),
                ),
                SizedBox(
                  height: 0.02 * size.height,
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  width: 0.95 * size.width,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Column(
                    children: const [
                      Text("My Blood Sugar Data",
                          style: TextStyle(
                            fontSize: 28,
                            fontFamily: 'Inria Serif',
                          )),
                      LineChart(),
                    ],
                  ),
                ),
                SizedBox(
                  height: 0.02 * size.height,
                ),
                Container(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () async {
                      await showInformationDialog(
                          context); // Navigator.pushNamed(context, '/LoggingFood');
                    },
                    child: const Text("Log Current Sugar Level",
                        style: TextStyle(
                          fontSize: 28,
                          fontFamily: 'Inria Serif',
                        )),
                    style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all<Size>(const Size(314, 70)),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(255, 255, 75, 58)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 0.02 * size.height,
                ),
                Container(
                  padding: EdgeInsets.all(8.0),
                  width: 0.95 * size.width,
                  alignment: Alignment.bottomLeft,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Column(
                    children: const [
                      Text("Tip Of The Day:",
                          style: TextStyle(
                            fontSize: 28,
                            fontFamily: 'Inria Serif',
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      Text("Choose food with low levels of added sugar",
                          style: TextStyle(
                            fontSize: 28,
                            fontFamily: 'Inria Serif',
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
