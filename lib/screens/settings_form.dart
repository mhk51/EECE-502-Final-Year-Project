import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_application_1/screens/navdrawer.dart';
import 'package:flutter_application_1/services/auth.dart';
import 'package:flutter_application_1/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/custom/loading.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({Key? key}) : super(key: key);

  @override
  _SettingsFormState createState() => _SettingsFormState();
}

enum Gender { male, female }

class _SettingsFormState extends State<SettingsForm> {
  Future<String> showInformationDialog(
      String title, String textField, String value) async {
    return await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          final _formKey = GlobalKey<FormState>();
          final TextEditingController _textEditingController =
              TextEditingController();
          String result = value;
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
                          result = value;
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
                    primary: Colors.indigo[800],
                    backgroundColor: Colors.indigo[800],
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

  Future<String> showGenderDialog(String gender) async {
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

  final _auth = AuthService();
  final List<int> list = [for (var i = 3; i <= 22; i++) i];

  int age = 3;
  int height = 100;
  int weight = 40;
  String username = '';

  final textControllerUsername = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);
    return user == null
        ? const Loading()
        : StreamBuilder<Child?>(
            stream: DatabaseService(uid: user.uid).userData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Child? childData = snapshot.data;
                return DefaultTabController(
                  length: 3,
                  child: Scaffold(
                    resizeToAvoidBottomInset: false,
                    drawer: NavDrawer(),
                    appBar: AppBar(
                      bottom: TabBar(
                          isScrollable: true,
                          unselectedLabelColor: Colors.white.withOpacity(0.3),
                          indicatorColor: Colors.white,
                          tabs: const [
                            Tab(
                              child: Text('Personal'),
                            ),
                            Tab(
                              child: Text('Therapy'),
                            ),
                            Tab(
                              child: Text('Settings'),
                            ),
                          ]),
                      backgroundColor: Colors.indigo[800],
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
                    body: TabBarView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: ListView(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Center(
                                child: Stack(children: [
                                  CircleAvatar(
                                    backgroundColor: const Color(0xff00A3FF),
                                    radius: 61.0,
                                    child: CircleAvatar(
                                      radius: 58,
                                      backgroundImage: childData!.gender ==
                                              'male'
                                          ? const AssetImage('assets/male.jpg')
                                          : const AssetImage(
                                              'assets/female.jpg'),
                                    ),
                                  ),
                                  Positioned(
                                    right: 0,
                                    bottom: 0,
                                    child: Container(
                                      width: 35,
                                      height: 35,
                                      child: IconButton(
                                        iconSize: 15,
                                        icon: const Icon(Icons.edit),
                                        onPressed: () {},
                                      ),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 2, color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(90.0),
                                          color: Colors.grey[500]),
                                    ),
                                  ),
                                ]),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 50,
                                ),
                                onTap: () async {
                                  String result = await showInformationDialog(
                                      "Please enter your display name",
                                      "Display Name",
                                      childData.name!);
                                  await DatabaseService(uid: childData.uid)
                                      .updateUserDataCollection(
                                          result,
                                          childData.email!,
                                          childData.height,
                                          childData.age,
                                          childData.weight,
                                          childData.gender);
                                  await _auth.updateDisplayName(result);
                                },
                                title: Text(
                                  "Display Name",
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                                subtitle: Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  child: Text(
                                    childData.name!,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 50,
                                ),
                                title: Text(
                                  "Email",
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                                subtitle: Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  child: Text(
                                    childData.email!,
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 50,
                                ),
                                onTap: () async {
                                  await showInformationDialog(
                                      "Please enter your first name",
                                      "First Name",
                                      childData.firstName);
                                },
                                title: Text(
                                  "First Name",
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                                subtitle: Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  child: Text(
                                    childData.name!.split(" ")[0],
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 50,
                                ),
                                onTap: () async {
                                  await showInformationDialog(
                                      "Please enter your last name",
                                      "Last Name",
                                      childData.lastName);
                                },
                                title: Text(
                                  "Last Name",
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                                subtitle: Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  child: Text(
                                    childData.name!.split(" ")[1],
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 50,
                                ),
                                onTap: () async {
                                  dynamic result =
                                      await showGenderDialog(childData.gender);
                                  DatabaseService(uid: childData.uid)
                                      .updateUserDataCollection(
                                          childData.name!,
                                          childData.email!,
                                          childData.height,
                                          childData.age,
                                          childData.weight,
                                          result);
                                },
                                title: Text(
                                  "Sex",
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                                subtitle: Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  child: Text(
                                    childData.gender[0].toUpperCase() +
                                        childData.gender.substring(1),
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 50,
                                ),
                                onTap: () {},
                                title: Text(
                                  "Age - Birthdate",
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                                subtitle: Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  child: Text(
                                    "${childData.age.toString()} years old",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              OutlinedButton(
                                onPressed: () async {
                                  await _auth.resetPassowrd();
                                },
                                child: Text(
                                  'CHANGE PASSWORD',
                                  style: TextStyle(
                                    fontSize: 21,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                style: OutlinedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(9),
                                  ),
                                  side: BorderSide(
                                    width: 2,
                                    color: Colors.grey[600]!,
                                  ),
                                ),
                              ),
                              OutlinedButton(
                                onPressed: () async {
                                  await _auth.signOut();
                                },
                                child: const Text(
                                  'LOG OUT',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 21,
                                  ),
                                ),
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(
                                    width: 2,
                                    color: Colors.red,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(9),
                                  ),
                                  backgroundColor: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Text("Tab3 "),
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
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return const Loading();
              }
            });
  }
}
