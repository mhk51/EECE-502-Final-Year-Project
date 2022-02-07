import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/custom/border_box.dart';
import 'package:flutter_application_1/custom/line_chart.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_application_1/services/auth.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  final AuthService _auth = AuthService();
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);
    // print(user!.name);
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              // child: const SettingsForm(),
            );
          });
    }

    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.indigo[100],
        appBar: AppBar(
          backgroundColor: Colors.blue[800],
          title: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Home"),
          ),
          // centerTitle: true,
          actions: [
            TextButton.icon(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: const Icon(
                Icons.person,
                color: Colors.white,
              ),
              label: const Text(
                "Log Out",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Blood Sugar Graph:"),
              ),
              const SizedBox(
                height: 10,
              ),
              Text('Welcome ${user!.name}'),
              const LineChart(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const BorderBox(
                    padding: EdgeInsets.all(8.0),
                    width: 60,
                    height: 60,
                    child: Icon(
                      Icons.home,
                      color: Colors.black,
                    ),
                  ),
                  const BorderBox(
                    padding: EdgeInsets.all(8.0),
                    width: 60,
                    height: 60,
                    child: Icon(
                      Icons.list,
                      color: Colors.black,
                    ),
                  ),
                  const BorderBox(
                    padding: EdgeInsets.all(8.0),
                    width: 60,
                    height: 60,
                    child: Icon(
                      Icons.add,
                      color: Colors.black,
                    ),
                  ),
                  const BorderBox(
                    padding: EdgeInsets.all(8.0),
                    width: 60,
                    height: 60,
                    child: Icon(
                      Icons.graphic_eq,
                      color: Colors.black,
                    ),
                  ),
                  BorderBox(
                    padding: const EdgeInsets.all(8.0),
                    width: 60,
                    height: 60,
                    child: TextButton(
                      onPressed: () {
                        _showSettingsPanel();
                      },
                      child: const Icon(Icons.settings, color: Colors.black),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                      ),
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