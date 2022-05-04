import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/Authentication/registration_class.dart';
import 'package:provider/provider.dart';

class RegisterPage2 extends StatefulWidget {
  final PageController controller;
  final Function setProgressBar;
  const RegisterPage2(
      {Key? key, required this.controller, required this.setProgressBar})
      : super(key: key);

  @override
  State<RegisterPage2> createState() => _RegisterPage2State();
}

class _RegisterPage2State extends State<RegisterPage2> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    RegistrationClass registrationClass =
        Provider.of<RegistrationClass>(context);
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              "Welcome to (AppName)",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "We need to know you better before getting started...",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const Text(
                  "What is Your Name",
                  style: TextStyle(fontSize: 20),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (val) => registrationClass.firstname.isEmpty
                        ? 'Enter a Name'
                        : null,
                    onChanged: (val) {
                      registrationClass.changeFirstName(val);
                    },
                    decoration: const InputDecoration(
                      hintText: "Enter Full Name:",
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const Text(
                  "What Do you want us to call you?",
                  style: TextStyle(fontSize: 20),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (val) => registrationClass.lastname.isEmpty
                        ? 'Enter a Username'
                        : null,
                    onChanged: (val) {
                      registrationClass.changeLastName(val);
                    },
                    decoration: const InputDecoration(
                      hintText: "Enter UserName:",
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        widget.controller.nextPage(
                            duration: const Duration(seconds: 1),
                            curve: Curves.slowMiddle);
                        widget.setProgressBar(2);
                      }
                    },
                    child: const Text(
                      "Next",
                      style: TextStyle(fontSize: 20),
                    ),
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(size.width, 60)),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
