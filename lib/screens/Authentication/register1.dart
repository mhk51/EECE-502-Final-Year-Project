import 'package:flutter/material.dart';
import 'package:flutter_application_1/custom/constants.dart';
import 'package:flutter_application_1/screens/Authentication/registration_class.dart';
import 'package:provider/provider.dart';

class RegisterPage1 extends StatefulWidget {
  final Function setProgressBar;
  final PageController controller;
  const RegisterPage1({Key? key, required this.controller, required this.setProgressBar})
      : super(key: key);

  @override
  State<RegisterPage1> createState() => _RegisterPage1State();
}

class _RegisterPage1State extends State<RegisterPage1> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    RegistrationClass registrationClass = Provider.of<RegistrationClass>(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            const SizedBox(height: 20.0),
            TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Email...'),
                validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                onChanged: (val) {
                  registrationClass.changeEmail(val);
                }),
            const SizedBox(height: 20.0),
            TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Password...'),
                obscureText: true,
                validator: (val) => val!.length < 6 ? 'Enter a password 6+ chars long' : null,
                onChanged: (val) {
                  registrationClass.changePassword(val);
                }),
            const SizedBox(height: 20.0),
            TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Confirm Password...'),
                obscureText: true,
                validator: (val) =>
                    val != registrationClass.password ? 'Enter a matching password' : null,
                onChanged: (val) {
                  registrationClass.changeConfirmPassword(val);
                }),
            const SizedBox(height: 20.0),
            ElevatedButton(
              child: const Text(
                'Register',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  // setState(() => loading = true);
                  // CustomUser? result =
                  //     await _auth.registerWithEmailAndPassword(
                  //         email, password, username);
                  // if (result == null) {
                  //   setState(() {
                  //     error = 'Please supply a valid email';
                  //   });
                  // }
                  widget.controller
                      .nextPage(duration: const Duration(seconds: 1), curve: Curves.decelerate);
                  widget.setProgressBar(1);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink[400],
              ),
            ),
            const SizedBox(height: 12.0),
            Text(
              registrationClass.error,
              style: const TextStyle(color: Colors.red, fontSize: 14.0),
            )
          ],
        ),
      ),
    );
  }
}
