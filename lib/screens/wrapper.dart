import 'package:flutter_application_1/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/Authentication/authenticate.dart';
import 'package:flutter_application_1/screens/Authentication/register1.dart';
import 'package:flutter_application_1/screens/Authentication/sign_in.dart';
import 'package:flutter_application_1/screens/home_screen.dart';
import 'package:flutter_application_1/screens/landing_screen/landing_screen.dart';
import 'package:flutter_application_1/screens/recommendations/recommendations.dart';
import 'package:flutter_application_1/screens/signin/signin.dart';
import 'package:flutter_application_1/screens/signup/signup1.dart';
import 'package:flutter_application_1/screens/signup/signup3.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context, listen: true);
    // return either the Home or Authenticate widget
    if (user == null) {
      return const Authenticate();
    } else {
      return const SignUp3();
    }
  }
}
