import 'package:flutter/services.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_application_1/screens/navdrawer.dart';
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
  final List<int> list = [for (var i = 3; i <= 20; i++) i];

  int age = 3;
  int height = 100;
  int weight = 40;
  String username = '';

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);
    // if (user == null) {
    //   print('User null');
    //   Navigator.pushReplacementNamed(context, '/');
    // }
    return user == null
        ? Loading()
        : StreamBuilder<Child?>(
            stream: DatabaseService(uid: user.uid).userData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Child? childData = snapshot.data;
                return Form(
                  key: _formKey,
                  child: Scaffold(
                    drawer: NavDrawer(),
                    appBar: AppBar(
                      backgroundColor: Colors.blue[800],
                      title: const Text('Profile & Settings'),
                      centerTitle: true,
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/Home');
                          },
                          child: const Icon(Icons.check),
                          style: TextButton.styleFrom(
                            primary: Colors.white,
                          ),
                        )
                      ],
                    ),
                    body: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 100,
                          ),
                          // const Text(
                          //   'Display Name: ',
                          //   style: TextStyle(
                          //     fontSize: 18,
                          //   ),
                          // ),
                          // const SizedBox(
                          //   height: 20,
                          // ),
                          TextFormField(
                            decoration: textInputDecoration.copyWith(
                              hintText: childData!.name!,
                              enabledBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.pink, width: 2.0),
                              ),
                            ),
                            validator: (val) =>
                                val!.isEmpty ? 'Enter a username' : null,
                            onChanged: (val) {
                              setState(() => username = val);
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          DropdownButtonFormField<int>(
                            value: childData.age == 0 ? 3 : childData.age,
                            items: list.map((e) {
                              return DropdownMenuItem(
                                value: e,
                                child: Text('$e'),
                              );
                            }).toList(),
                            onChanged: (val) => setState(() => age = val!),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            decoration: textInputDecoration.copyWith(
                              hintText: childData.height.toString(),
                              enabledBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.pink, width: 2.0),
                              ),
                            ),
                            validator: (val) =>
                                int.parse(val!) > 200 || int.parse(val) < 100
                                    ? 'Enter Valid Height'
                                    : null,
                            onChanged: (val) {
                              setState(() {
                                try {
                                  height = int.parse(val);
                                } catch (e) {
                                  print(e.toString());
                                }
                              });
                            },
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            decoration: textInputDecoration.copyWith(
                              hintText: childData.weight.toString(),
                              enabledBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.pink, width: 2.0),
                              ),
                            ),
                            validator: (val) =>
                                int.parse(val!) > 120 || int.parse(val) < 20
                                    ? 'Enter Valid Weight'
                                    : null,
                            onChanged: (val) {
                              setState(() {
                                try {
                                  weight = int.parse(val);
                                } catch (e) {
                                  print(e.toString());
                                }
                              });
                            },
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                await _auth.updateDisplayName(username);
                                await DatabaseService(uid: user.uid)
                                    .updateUserDataCollection(
                                        username,
                                        childData.email!,
                                        height,
                                        age,
                                        weight,
                                        'male');
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
                            height: 10,
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
                  ),
                );
              } else {
                return const Loading();
              }
            });
  }
}
