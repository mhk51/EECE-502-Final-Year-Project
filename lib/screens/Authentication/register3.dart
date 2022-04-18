// ignore_for_file: empty_catches

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_application_1/screens/Authentication/registration_class.dart';
import 'package:flutter_application_1/services/database.dart';
import 'package:flutter_application_1/services/therapy_database.dart';
import 'package:provider/provider.dart';

class RegisterPage3 extends StatefulWidget {
  final PageController controller;
  final Function setProgressBar;
  const RegisterPage3(
      {Key? key, required this.controller, required this.setProgressBar})
      : super(key: key);

  @override
  State<RegisterPage3> createState() => _RegisterPage3State();
}

class _RegisterPage3State extends State<RegisterPage3> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    RegistrationClass registrationClass =
        Provider.of<RegistrationClass>(context);
    final Size size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Hey ${registrationClass.username}!",
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  registrationClass.setGender(true);
                },
                child: const Text(
                  " Male ",
                  style: TextStyle(fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                    primary: registrationClass.isGenderMale
                        ? Colors.red
                        : Colors.blue),
              ),
              const SizedBox(
                width: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  registrationClass.setGender(false);
                },
                child: const Text(
                  "Female",
                  style: TextStyle(fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                    primary: registrationClass.isGenderMale
                        ? Colors.blue
                        : Colors.red),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                const Text(
                  "What is your age?",
                  style: TextStyle(fontSize: 20),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  // ignore: unnecessary_const
                  child: TextFormField(
                    validator: (val) => val!.isEmpty ? 'Enter an age' : null,
                    onChanged: (value) {
                      try {
                        registrationClass.changeAge(int.parse(value));
                      } catch (e) {}
                    },
                    decoration: const InputDecoration(
                      hintText: "Enter Age:",
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                const Text(
                  "How tall are you?",
                  style: TextStyle(fontSize: 20),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (val) => val!.isEmpty ? 'Enter a height' : null,
                    onChanged: (value) {
                      try {
                        registrationClass.changeHeight(int.parse(value));
                      } catch (e) {}
                    },
                    decoration: const InputDecoration(
                      hintText: "Enter height:",
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                const Text(
                  "How much do you weigh?",
                  style: TextStyle(fontSize: 20),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (val) => val!.isEmpty ? 'Enter a weight' : null,
                    onChanged: (value) {
                      try {
                        registrationClass.changeWeight(int.parse(value));
                      } catch (e) {}
                    },
                    decoration: const InputDecoration(
                      hintText: "Enter weight:",
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  registrationClass.setLoading(true);
                  CustomUser? result = await registrationClass.registerUser();
                  if (result == null) {
                    widget.controller.animateToPage(0,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.bounceIn);
                    registrationClass.setLoading(false);
                    registrationClass
                        .changeError('Please Supply a Valid Email');
                  } else {
                    await DatabaseService(uid: result.uid)
                        .updateUserDataCollection(
                      registrationClass.username,
                      registrationClass.email,
                      registrationClass.height,
                      registrationClass.age,
                      registrationClass.weight,
                      registrationClass.isGenderMale ? 'male' : 'female',
                    );
                    await TherapyDatabaseService(uid: result.uid)
                        .updateUserTherapyCollection(
                            11.0,
                            8.0,
                            5.6,
                            4.6,
                            3.0,
                            15.0,
                            10.0,
                            6.0,
                            '7:00',
                            '10:00',
                            '12:00',
                            '15:00',
                            '18:00',
                            '20:00',
                            -1,
                            -1);
                  }
                }

                //
                // CustomUser? result =
                //     await _auth.registerWithEmailAndPassword(
                //         email, password, username);
                // if (result == null) {
                //   controller.animateToPage(0,
                //       duration: const Duration(milliseconds: 500),
                //       curve: Curves.bounceIn);
                //   setState(() {
                //     loading = false;
                //     error = 'Please supply a valid email';
                //   });
                // } else {
                //   await DatabaseService(uid: result.uid)
                //       .updateUserDataCollection(
                //     username,
                //     email,
                //     height,
                //     age,
                //     weight,
                //     isGenderMale ? 'male' : 'female',
                //   );
                // }
              },
              child: const Text(
                "Submit",
                style: TextStyle(fontSize: 20),
              ),
              style:
                  ElevatedButton.styleFrom(minimumSize: Size(size.width, 60)),
            ),
          )
        ],
      ),
    );
  }
}
