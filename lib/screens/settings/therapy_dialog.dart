import 'package:flutter/material.dart';

Future<double> showTherapyDialog(
    BuildContext context, String title, String textField, double value) async {
  return await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        final _formKey = GlobalKey<FormState>();
        final TextEditingController _textEditingController = TextEditingController();
        double result = value;
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      title,
                      style: const TextStyle(
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
                    child: TextFormField(
                      cursorColor: Colors.indigo[800],
                      validator: (value) {
                        return value!.isNotEmpty ? null : "Invalid Field";
                      },
                      decoration: InputDecoration(
                        hintText: textField,
                        fillColor: Colors.grey[200],
                        filled: true,
                      ),
                      controller: _textEditingController,
                      onChanged: (value) {
                        try {
                          result = double.parse(value);
                          // ignore: empty_catches
                        } catch (e) {}
                      },
                    ),
                  ),
                ],
              )),
          actions: <Widget>[
            Container(
              margin: const EdgeInsets.all(8),
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context, value);
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
            Container(
              margin: const EdgeInsets.all(8),
              child: TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pop(context, result);
                  }
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: const Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text(
                    "SAVE",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            )
          ],
        );
      });
}
