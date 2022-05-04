import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/settings/settings_form.dart';

Future<String?> showGenderDialog(BuildContext context, String gender) async {
  Gender _character = gender == 'male' ? Gender.male : Gender.female;
  return await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Please choose your sex',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Divider(
                thickness: 0.7,
                color: Colors.grey[400],
              ),
              Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      RadioListTile<Gender>(
                        title: const Text('Male'),
                        value: Gender.male,
                        groupValue: _character,
                        onChanged: (Gender? value) {
                          Navigator.pop(context, 'male');
                        },
                      ),
                      RadioListTile<Gender>(
                        title: const Text('Female'),
                        value: Gender.female,
                        groupValue: _character,
                        onChanged: (Gender? value) {
                          Navigator.pop(context, 'female');
                        },
                      ),
                    ],
                  )),
            ],
          ),
          actions: <Widget>[
            Container(
              margin: const EdgeInsets.all(8),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "CANCEL",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        );
      });
}
