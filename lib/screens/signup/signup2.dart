// ignore_for_file: empty_catches

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../custom/constants.dart';
import '../Authentication/registration_class.dart';

class SignUp2 extends StatefulWidget {
  const SignUp2({Key? key}) : super(key: key);

  @override
  State<SignUp2> createState() => _SignUp2State();
}

class _SignUp2State extends State<SignUp2> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    RegistrationClass registrationClass =
        Provider.of<RegistrationClass>(context);
    var defaultGender = 'Male';
    var genderType = ["Male", "Female"];
    return SafeArea(
      child: Scaffold(
          backgroundColor: const Color.fromARGB(242, 242, 242, 242),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.43,
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
                              registrationClass
                                  .setSignUpScreen(SignUpScreen.signup1);
                            },
                            icon: const Icon(Icons.arrow_back))),
                    const Positioned(
                      left: 24,
                      right: 122,
                      top: 75,
                      child: Text(
                        "What Should I Eat?", overflow: TextOverflow.visible,
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
                      right: 0,
                      bottom: 15,
                      child: Text(
                        "General Info", overflow: TextOverflow.visible,
                        textAlign: TextAlign.left,
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
                        padding:
                            const EdgeInsets.only(left: 50, right: 50, top: 20),
                        child: TextFormField(
                          validator: (val) =>
                              val!.isEmpty ? 'Enter an age' : null,
                          onChanged: (value) {
                            try {
                              registrationClass.changeAge(int.parse(value));
                            } catch (e) {}
                          },
                          decoration: const InputDecoration(
                            labelText: 'Age',
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 50, right: 50, top: 20),
                        child: TextFormField(
                          validator: (val) =>
                              val!.isEmpty ? 'Enter a weight' : null,
                          onChanged: (value) {
                            try {
                              registrationClass.changeWeight(int.parse(value));
                            } catch (e) {}
                          },
                          decoration: const InputDecoration(
                            labelText: 'Weight  (kg)',
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 50, right: 50, top: 20),
                        child: TextFormField(
                          validator: (val) =>
                              val!.isEmpty ? 'Enter a height' : null,
                          onChanged: (value) {
                            try {
                              registrationClass.changeHeight(int.parse(value));
                            } catch (e) {}
                          },
                          decoration: const InputDecoration(
                            labelText: 'Height  (cm)',
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 50, right: 50, top: 20),
                        child: DropdownButtonFormField<String>(
                            value: defaultGender,
                            decoration: textInputDecoration,
                            items: genderType.map((gender) {
                              return DropdownMenuItem(
                                value: gender,
                                child: Text(gender),
                              );
                            }).toList(),
                            onChanged: (val) {
                              setState(() => defaultGender = val!);
                              if (val == "Male") {
                                registrationClass.setGender(true);
                              } else if (val == "Female") {
                                registrationClass.setGender(false);
                              }
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 40, top: 30),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              registrationClass
                                  .setSignUpScreen(SignUpScreen.signup3);
                            }
                          },
                          style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all<Size>(
                                const Size(314, 70)),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color.fromARGB(255, 255, 75, 58)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                          ),
                          child: const Text(
                            "Next",
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
