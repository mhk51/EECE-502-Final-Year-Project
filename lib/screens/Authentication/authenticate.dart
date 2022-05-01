import 'package:flutter_application_1/screens/Authentication/sign_in.dart';
import 'package:flutter_application_1/screens/Authentication/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/signin/signin.dart';
import 'package:flutter_application_1/screens/signup/signup1.dart';
import 'package:flutter_application_1/screens/signup/signup2.dart';
import 'package:flutter_application_1/screens/signup/signup3.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn1(toggleView: toggleView);
    } else {
      return Register(toggleView: toggleView);
    }
    // return PageView(
    //   children: [
    //     SignIn1(),
    //     SignUp1(),
    //     SignUp2(),
    //     SignUp3(),
    //   ],
    // );
  }
}
