import 'package:flutter_application_1/screens/Authentication/registration_class.dart';
import 'package:flutter_application_1/screens/Authentication/sign_in.dart';
import 'package:flutter_application_1/screens/Authentication/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/signin/signin.dart';
import 'package:flutter_application_1/screens/signup/signup1.dart';
import 'package:flutter_application_1/screens/signup/signup2.dart';
import 'package:flutter_application_1/screens/signup/signup3.dart';
import 'package:provider/provider.dart';

import '../../custom/loading.dart';

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
      return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => RegistrationClass(),
            ),
          ],
          builder: (context, child) {
            bool loading = Provider.of<RegistrationClass>(context).loading;
            return loading ? const Loading() : SignUp1();
          });
    }
  }
}
