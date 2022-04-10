import 'package:flutter_application_1/custom/constants.dart';
import 'package:flutter_application_1/custom/loading.dart';
import 'package:flutter_application_1/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  const SignIn({Key? key, required this.toggleView}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;
  String email = '';
  String password = '';

  void onChangedEmail(val) {
    email = val;
  }

  void onChangedPass(val) {
    password = val;
  }

  String? passwordValidator(val) {
    return val!.length < 6 ? 'Enter a password 6+ chars long' : null;
  }

  String? emailValidator(val) {
    return val!.isEmpty ? 'Enter an email' : null;
  }

  void signIn() async {
    // if (_formKey.currentState!.validate()) {
    //   setState(() => loading = true);
    //   dynamic result = await _auth.signInWithEmailAndPassword(email, password);
    //   if (result == null) {
    //     setState(() {
    //       loading = false;
    //       error = 'Could not sign in with those credentials';
    //     });
    //   }
    // }
  }

  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    double resize = MediaQuery.of(context).viewInsets.bottom - 100;
    controller.animateTo(resize > 0 ? resize : 0,
        duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
    return loading
        ? const Loading()
        : Scaffold(
            backgroundColor: Colors.indigo[100],
            body: SingleChildScrollView(
              controller: controller,
              physics: const ScrollPhysics(parent: BouncingScrollPhysics()),
              child: Container(
                color: const Color(0xFFfafafa),
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 40.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      logo(),
                      logoText(),
                      inputField(const Icon(Icons.person), 'Email', false,
                          onChangedEmail, emailValidator),
                      inputField(const Icon(Icons.lock), 'Password', true,
                          onChangedPass, passwordValidator),
                      loginBtn(signIn),
                      dontHaveAcnt(),
                      signUp(widget.toggleView),
                      terms(),
                      Text(
                        error,
                        style:
                            const TextStyle(color: Colors.red, fontSize: 14.0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
