import 'package:flutter/material.dart';

import '../../custom/loading.dart';
import '../../services/auth.dart';

class SignIn1 extends StatefulWidget {
  final Function toggleLanding;
  const SignIn1({Key? key, required this.toggleLanding}) : super(key: key);

  @override
  State<SignIn1> createState() => _SignIn1State();
}

class _SignIn1State extends State<SignIn1> {
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
    if (_formKey.currentState!.validate()) {
      setState(() => loading = true);
      dynamic result = await _auth.signInWithEmailAndPassword(email, password);
      if (result == null) {
        setState(() {
          loading = false;
          error = 'Could not sign in with those credentials';
        });
      }
    }
  }

  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: loading
          ? const Loading()
          : Scaffold(
              backgroundColor: const Color.fromARGB(242, 242, 242, 242),
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                controller: controller,
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: MediaQuery.of(context).size.width,
                      // color: Color.fromARGB(255, 255, 255, 255),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      child: Stack(children: [
                        Positioned(
                            left: 24,
                            top: 10,
                            child: IconButton(
                                onPressed: () {
                                  widget.toggleLanding();
                                },
                                icon: const Icon(Icons.arrow_back))),
                        const Positioned(
                          left: 24,
                          right: 122,
                          top: 75,
                          child: Text(
                            "What Should I Eat?",
                            overflow: TextOverflow.visible,
                            textAlign: TextAlign.left,
                            // textScaleFactor: textScaleFactor,
                            style: TextStyle(
                              height: 0.8683594336876502,
                              fontSize: 65.0,
                              fontFamily: 'Inria Serif',
                              fontWeight: FontWeight.w400,
                              color: Colors.black,

                              /* letterSpacing: -1.95, */
                            ),
                          ),
                        ),
                        Positioned(
                          left: 220,
                          top: 30,
                          child: Image.asset("assets/images/carrot.png"),
                        ),
                        const Positioned(
                          left: 65,
                          right: 65,
                          bottom: 24,
                          child: Text(
                            "Log In", overflow: TextOverflow.visible,
                            textAlign: TextAlign.center,
                            // textScaleFactor: textScaleFactor,
                            style: TextStyle(
                              height: 0.8683594336876502,
                              fontSize: 48.0,
                              fontFamily: 'Inria Serif',
                              fontWeight: FontWeight.w400,
                              color: Colors.black,

                              /* letterSpacing: -1.95, */
                            ),
                          ),
                        ),
                      ]),
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 50, right: 50, top: 60),
                            child: TextFormField(
                              validator: (val) => emailValidator(val),
                              onChanged: (val) => onChangedEmail(val),
                              decoration: const InputDecoration(
                                labelText: 'Email',
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 50, right: 50, top: 50),
                            child: TextFormField(
                              validator: (val) => passwordValidator(val),
                              onChanged: (val) => onChangedPass(val),
                              obscureText: true,
                              decoration: const InputDecoration(
                                labelText: 'Password',
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 40, top: 60),
                            child: ElevatedButton(
                              onPressed: () => signIn(),
                              style: ButtonStyle(
                                minimumSize: MaterialStateProperty.all<Size>(
                                    const Size(314, 70)),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        const Color.fromARGB(255, 255, 75, 58)),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),
                              ),
                              child: const Text(
                                "Log In",
                                // textScaleFactor: textScaleFactor,
                                overflow: TextOverflow.visible,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  height: 0.8683594336876502,
                                  fontSize: 24.0,
                                  fontFamily: 'Inria Serif',
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,

                                  /* letterSpacing: -1.95, */
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )),
    );
  }
}
