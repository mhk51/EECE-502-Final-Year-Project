import 'package:flutter_application_1/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/Authentication/authenticate.dart';
import 'package:flutter_application_1/screens/home_screen.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);

    // return either the Home or Authenticate widget
    if (user == null) {
      return const Authenticate();
    } else {
      return HomeScreen();
    }
  }
}