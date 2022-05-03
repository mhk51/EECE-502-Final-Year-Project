import 'package:flutter_application_1/screens/Authentication/registration_class.dart';
import 'package:flutter_application_1/screens/Authentication/sign_in.dart';
import 'package:flutter_application_1/screens/Authentication/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/landing_screen/landing_screen.dart';
import 'package:flutter_application_1/screens/signin/signin.dart';
import 'package:flutter_application_1/screens/signup/signup1.dart';
import 'package:flutter_application_1/screens/signup/signup2.dart';
import 'package:flutter_application_1/screens/signup/signup3.dart';
import 'package:provider/provider.dart';

enum AuthenticateScreen { landingScreen, signUp, signIn }

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  AuthenticateScreen authScreen = AuthenticateScreen.landingScreen;
  bool showSignIn = true;
  void toggleLanding() {
    setState(() {
      authScreen = AuthenticateScreen.landingScreen;
    });
  }

  void toggleSignUp() {
    setState(() {
      authScreen = AuthenticateScreen.signUp;
    });
  }

  void toggleSignIn() {
    setState(() {
      authScreen = AuthenticateScreen.signIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (authScreen == AuthenticateScreen.landingScreen) {
      return LandingScreen(
        toggleSignIn: toggleSignIn,
        toggleSignUp: toggleSignUp,
      );
    } else if (authScreen == AuthenticateScreen.signIn) {
      return SignIn1(toggleLanding: toggleLanding);
    } else {
      return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => RegistrationClass(),
            ),
          ],
          builder: (context, child) {
            bool loading = Provider.of<RegistrationClass>(context).loading;
            SignUpScreen screen =
                Provider.of<RegistrationClass>(context).signUpScreen;
            if (screen == SignUpScreen.signup1) {
              return SignUp1(
                toggleLanding: toggleLanding,
              );
            } else if (screen == SignUpScreen.signup2) {
              return SignUp2();
            } else {
              return SignUp3();
            }
          });
    }
  }
}
