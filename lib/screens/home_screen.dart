import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/custom/line_chart.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_application_1/screens/navdrawer.dart';
import 'package:flutter_application_1/services/auth.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
                  ],
                )),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text("Submit"))
            ],
          );
        });
  }

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final _auth = AuthService();
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
                    style: TextStyle(fontSize: 20)),
              ),
              const LineChart(),
              Container(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () async {
                    // await showInformationDialog(
                    //     context); // Navigator.pushNamed(context, '/LoggingFood');
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
