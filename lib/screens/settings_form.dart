import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_application_1/services/auth.dart';
import 'package:flutter_application_1/services/database.dart';
import 'package:flutter_application_1/custom/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/custom/loading.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({Key? key}) : super(key: key);

  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  // form values
  // String _currentName = "";
  // String _currentSugars = "";
  // // ignore: prefer_final_fields
  // int _currentStrength = 0;
  String username = '';

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);
    return Container(
      padding: const EdgeInsets.all(0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Text(
              user!.name!,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration:
                  textInputDecoration.copyWith(hintText: 'Dispaly Name...'),
              validator: (val) => val!.isEmpty ? 'Enter a username' : null,
              onChanged: (val) {
                setState(() => username = val);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  await _auth.updateDisplayName(username);
                  Navigator.pop(context);
                }
              },
              child: const Text(
                'Update',
                style: TextStyle(color: Colors.white),
              ),
              style: TextButton.styleFrom(
                backgroundColor: Colors.pink[400],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () async {
                await _auth.resetPassowrd();
              },
              child: const Text(
                'Reset Password',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              style: TextButton.styleFrom(
                backgroundColor: Colors.pink[400],
              ),
            )
          ],
        ),
      ),
    );
  }
}
