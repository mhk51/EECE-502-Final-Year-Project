import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
  final AuthService _auth = AuthService();

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
          // centerTitle: true,
          // actions: [
          //   TextButton.icon(
          //     onPressed: () async {
          //       await _auth.signOut();
          //     },
          //     icon: const Icon(
          //       Icons.person,
          //       color: Colors.white,
          //     ),
          //     label: const Text(
          //       "Log Out",
          //       style: TextStyle(
          //         color: Colors.white,
          //       ),
          //     ),
          //   )
          // ],
          actions: [
            TextButton.icon(
              onPressed: () {
                Navigator.pushReplacementNamed(context, "/Search");
              },
              icon: const Icon(
                Icons.search,
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
                    await Navigator.pushNamed(context, '/LoggingFood');
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
