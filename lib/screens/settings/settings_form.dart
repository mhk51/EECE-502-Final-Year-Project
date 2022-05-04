import 'package:flutter_application_1/custom/constants.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_application_1/screens/navdrawer.dart';
import 'package:flutter_application_1/screens/settings/personal_tab.dart';
import 'package:flutter_application_1/screens/settings/therapy_tab.dart';
import 'package:flutter_application_1/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/custom/loading.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({Key? key}) : super(key: key);

  @override
  _SettingsFormState createState() => _SettingsFormState();
}

enum Gender { male, female }

class _SettingsFormState extends State<SettingsForm> {
  final _auth = AuthService();

  String displayName = "";

  void changeDisplayName(String newName) {
    displayName = newName;
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);
    if (user == null) {
      return const Loading();
    } else {
      displayName = user.name!;
      return DefaultTabController(
        length: 3,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            bottom: TabBar(
                isScrollable: true,
                unselectedLabelColor: Colors.white.withOpacity(0.3),
                indicatorColor: Colors.white,
                tabs: const [
                  Tab(
                    child: Text('Personal'),
                  ),
                  Tab(
                    child: Text('Therapy'),
                  ),
                  Tab(
                    child: Text('Settings'),
                  ),
                ]),
            backgroundColor: primaryColor,
            title: const Text('Profile & Settings'),
            centerTitle: true,
            actions: [
              TextButton(
                onPressed: () async {
                  await AuthService().updateDisplayName(displayName);
                  Navigator.pushReplacementNamed(context, '/Home');
                },
                child: const Icon(Icons.check),
                style: TextButton.styleFrom(
                  primary: Colors.white,
                ),
              )
            ],
          ),
          body: TabBarView(
            children: [
              PersonalTab(
                changeDisplayName: changeDisplayName,
              ),
              const TherapyTab(),
              TextButton(
                onPressed: () async {
                  await _auth.resetPassowrd();
                },
                child: const Text(
                  'Reset Password',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.pink[400],
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
