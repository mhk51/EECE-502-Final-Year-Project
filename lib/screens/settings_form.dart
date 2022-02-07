import 'package:flutter_application_1/models/user.dart';
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
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  // form values
  String _currentName = "";
  String _currentSugars = "";
  // ignore: prefer_final_fields
  int _currentStrength = 0;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);
    return Container();
  }
}
