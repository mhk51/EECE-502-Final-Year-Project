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
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = AuthService();
  List<String> mealType = ["Breakfast", "Lunch", "Dinner", "Snack"];
  List<String> prepost = ["Before Meal", "After Meal"];
  String defaultMeal = "Breakfast";
  String defaultPrepost = "Before Meal";

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

                    //
                    //
                    //
                  ],
                )),
            actions: <Widget>[
              TextButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      TimeOfDay now = TimeOfDay.now();
                      LoggedBSL currentBSL = LoggedBSL(
                          double.parse(_textEditingController.text),
                          DateTime.now());
                      LoggedBSL.chartData.add(currentBSL);
                      print(currentBSL.level);
                      final uid = _auth.getUID();
                      await BloodSugarDatabaseService(uid: uid)
                          .updateuserBloodSugarCollection(currentBSL.level,
                              defaultMeal, defaultPrepost, DateTime.now());
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text("Submit"))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);
    // print(user!.name);
    // void _showSettingsPanel() {
    //   showModalBottomSheet(
    //       context: context,
    //       builder: (context) {
    //         return Container(
    //           padding:
    //               const EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
    //           child: const SettingsForm(),
    //         );
    //       });
    // }
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blue[800],
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
        // bottomNavigationBar: Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //     children: [
        //       BorderBox(
        //         padding: const EdgeInsets.all(8.0),
        //         width: 60,
        //         height: 60,
        //         child: TextButton(
        //           onPressed: () async {
        //             await Navigator.pushReplacementNamed(context, '/Home');
        //           },
        //           child: const Icon(
        //             Icons.home,
        //             color: Colors.black,
        //           ),
        //           style: TextButton.styleFrom(
        //             backgroundColor: Colors.white,
        //           ),
        //         ),
        //       ),
        //       BorderBox(
        //         padding: const EdgeInsets.all(8.0),
        //         width: 60,
        //         height: 60,
        //         child: TextButton(
        //           onPressed: () async {
        //             await Navigator.pushReplacementNamed(
        //                 context, '/DailyLogging');
        //           },
        //           child: const Icon(
        //             Icons.list,
        //             color: Colors.black,
        //           ),
        //           style: TextButton.styleFrom(
        //             backgroundColor: Colors.white,
        //           ),
        //         ),
        //       ),
        //       BorderBox(
        //         padding: const EdgeInsets.all(8.0),
        //         width: 60,
        //         height: 60,
        //         child: TextButton(
        //           onPressed: () async {
        //             await Navigator.pushNamed(context, '/LoggingFood');

        //             ///ItemInfo'
        //           },
        //           child: const Icon(Icons.add, color: Colors.black),
        //           style: TextButton.styleFrom(
        //             backgroundColor: Colors.white,
        //           ),
        //         ),
        //       ),
        //       BorderBox(
        //         padding: const EdgeInsets.all(8.0),
        //         width: 60,
        //         height: 60,
        //         child: TextButton(
        //           onPressed: () async {
        //             await Navigator.pushNamed(context, '/Insights');
        //           },
        //           child: const Icon(Icons.graphic_eq, color: Colors.black),
        //           style: TextButton.styleFrom(
        //             backgroundColor: Colors.white,
        //           ),
        //         ),
        //       ),
        //       BorderBox(
        //         padding: const EdgeInsets.all(8.0),
        //         width: 60,
        //         height: 60,
        //         child: TextButton(
        //           onPressed: () {
        //             _showSettingsPanel();
        //           },
        //           child: const Icon(
        //             Icons.settings,
        //             color: Colors.black,
        //           ),
        //           style: TextButton.styleFrom(
        //             backgroundColor: Colors.white,
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Welcome ${user!.name}',
                    style: const TextStyle(fontSize: 20)),
              ),
              const LineChart(),
              Container(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () async {
                    await showInformationDialog(
                        context); // Navigator.pushNamed(context, '/LoggingFood');
                  },
                  child: const Text("Log Current Sugar Level"),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(340, 40),
                    alignment: Alignment.center,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Tip Of The Day:"),
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Choose food with low levels of added sugar"),
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Positioned(
                      bottom: 0,
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          verticalDirection: VerticalDirection.down,
                        ),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
