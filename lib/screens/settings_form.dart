import 'package:flutter_application_1/custom/constants.dart';
import 'package:flutter_application_1/models/therapy.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_application_1/screens/navdrawer.dart';
import 'package:flutter_application_1/services/auth.dart';
import 'package:flutter_application_1/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/custom/loading.dart';
import 'package:flutter_application_1/services/therapy_database.dart';
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

  Future<double> showTherapyDialog(
      String title, String textField, double value) async {
    return await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          final _formKey = GlobalKey<FormState>();
          final TextEditingController _textEditingController =
              TextEditingController();
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
                      backgroundColor: primaryColor,
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
                                    backgroundColor: primaryColor,
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
                                    (childData.name!.split(" ").length == 1)
                                        ? ""
                                        : childData.name!.split(" ")[1],
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
                        StreamBuilder<Therapy>(
                            stream: TherapyDatabaseService(uid: childData.uid)
                                .userTherapyData,
                            builder: (context, snapshot) {
                              return (snapshot.connectionState ==
                                          ConnectionState.active &&
                                      snapshot.hasData)
                                  ? Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: ListView(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                left: 50, top: 20),
                                            child: Text(
                                              'Glucose Levels Target Range',
                                              style: TextStyle(
                                                  color: primaryColor,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          ListTile(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                              horizontal: 50,
                                            ),
                                            onTap: () async {
                                              String result =
                                                  await showInformationDialog(
                                                      "Please enter your display name",
                                                      "Display Name",
                                                      childData.name!);
                                              await DatabaseService(
                                                      uid: childData.uid)
                                                  .updateUserDataCollection(
                                                      result,
                                                      childData.email!,
                                                      childData.height,
                                                      childData.age,
                                                      childData.weight,
                                                      childData.gender);
                                              await _auth
                                                  .updateDisplayName(result);
                                            },
                                            title: const Text(
                                              "Hyperglycemia",
                                            ),
                                            subtitle: Text(
                                              '${snapshot.data!.hyperglycemia.toString()} mmol/L',
                                            ),
                                          ),
                                          ListTile(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                              horizontal: 50,
                                            ),
                                            title: const Text(
                                              "Glucose High",
                                            ),
                                            subtitle: Text(
                                              '${snapshot.data!.glucoseHigh.toString()} mmol/L',
                                            ),
                                          ),
                                          ListTile(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                              horizontal: 50,
                                            ),
                                            onTap: () async {
                                              await showInformationDialog(
                                                  "Please enter your first name",
                                                  "First Name",
                                                  childData.firstName);
                                            },
                                            title: const Text(
                                              "Glucose Target",
                                            ),
                                            subtitle: Text(
                                              '${snapshot.data!.glucoseTarget.toString()} mmol/L',
                                            ),
                                          ),
                                          ListTile(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                              horizontal: 50,
                                            ),
                                            onTap: () async {
                                              await showInformationDialog(
                                                  "Please enter your last name",
                                                  "Last Name",
                                                  childData.lastName);
                                            },
                                            title: const Text(
                                              "Glucose Low",
                                            ),
                                            subtitle: Text(
                                                '${snapshot.data!.glucoseLow.toString()} mmol/L'),
                                          ),
                                          ListTile(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                              horizontal: 50,
                                            ),
                                            onTap: () async {
                                              dynamic result =
                                                  await showGenderDialog(
                                                      childData.gender);
                                              DatabaseService(
                                                      uid: childData.uid)
                                                  .updateUserDataCollection(
                                                      childData.name!,
                                                      childData.email!,
                                                      childData.height,
                                                      childData.age,
                                                      childData.weight,
                                                      result);
                                            },
                                            title: const Text(
                                              "Hypoglycemia",
                                            ),
                                            subtitle: Text(
                                              '${snapshot.data!.hypoglycemia.toString()} mmol/L',
                                            ),
                                          ),
                                          Divider(
                                            height: 20,
                                            thickness: 1.5,
                                            color: Colors.grey[600],
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                left: 50, top: 20),
                                            child: Text(
                                              'Target Range After Meal',
                                              style: TextStyle(
                                                  color: primaryColor,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          ListTile(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                              horizontal: 50,
                                            ),
                                            onTap: () {},
                                            title: const Text(
                                              "Hyperglycemia",
                                            ),
                                            subtitle: Text(
                                              '${snapshot.data!.hyperglycemiaAfterMeal.toString()} mmol/L',
                                            ),
                                          ),
                                          ListTile(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                              horizontal: 50,
                                            ),
                                            onTap: () {},
                                            title: const Text(
                                              "Glucose High",
                                            ),
                                            subtitle: Text(
                                              '${snapshot.data!.glucoseHighAfterMeal.toString()} mmol/L',
                                            ),
                                          ),
                                          ListTile(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                              horizontal: 50,
                                            ),
                                            onTap: () {},
                                            title: const Text(
                                              "Glucose Low",
                                            ),
                                            subtitle: Text(
                                              '${snapshot.data!.glucoseLowAfterMeal.toString()} mmol/L',
                                            ),
                                          ),
                                          Divider(
                                            height: 20,
                                            thickness: 1.5,
                                            color: Colors.grey[600],
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                left: 50, top: 20),
                                            child: Text(
                                              'Ratio and sensitivity Settings',
                                              style: TextStyle(
                                                  color: primaryColor,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          ListTile(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                              vertical: 10,
                                              horizontal: 50,
                                            ),
                                            onTap: () async {
                                              double result =
                                                  await showTherapyDialog(
                                                      "Carbohydrates ratio (hourly)",
                                                      "00.000",
                                                      snapshot.data!
                                                          .carbohydratesRatio!);
                                              await TherapyDatabaseService(
                                                      uid: childData.uid)
                                                  .updateUserTherapyCollection(
                                                      snapshot
                                                          .data!.hyperglycemia,
                                                      snapshot
                                                          .data!.glucoseHigh,
                                                      snapshot
                                                          .data!.glucoseTarget,
                                                      snapshot.data!.glucoseLow,
                                                      snapshot
                                                          .data!.hypoglycemia,
                                                      snapshot.data!
                                                          .hyperglycemiaAfterMeal,
                                                      snapshot.data!
                                                          .glucoseHighAfterMeal,
                                                      snapshot.data!
                                                          .glucoseLowAfterMeal,
                                                      snapshot.data!
                                                          .breakFastStartTime,
                                                      snapshot.data!
                                                          .breakFastEndTime,
                                                      snapshot
                                                          .data!.lunchStartTime,
                                                      snapshot
                                                          .data!.lunchEndTime,
                                                      snapshot.data!
                                                          .dinnerStartTime,
                                                      snapshot
                                                          .data!.dinnerEndTime,
                                                      snapshot.data!
                                                          .insulinSensitivity!,
                                                      result);
                                            },
                                            title: const Text(
                                              "Carbohydrates ratio (hourly)",
                                            ),
                                            subtitle: Text(
                                              'The amount of carbohydrates in grams covered by 1 insulin unit ${(snapshot.data!.carbohydratesRatio == -1) ? '' : '\n00:00->' + snapshot.data!.carbohydratesRatio.toString()}',
                                            ),
                                          ),
                                          ListTile(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                              vertical: 10,
                                              horizontal: 50,
                                            ),
                                            onTap: () async {
                                              double result =
                                                  await showTherapyDialog(
                                                      "Carbohydrates ratio (hourly)",
                                                      "00.000",
                                                      snapshot.data!
                                                          .carbohydratesRatio!);
                                              await TherapyDatabaseService(
                                                      uid: childData.uid)
                                                  .updateUserTherapyCollection(
                                                      snapshot
                                                          .data!.hyperglycemia,
                                                      snapshot
                                                          .data!.glucoseHigh,
                                                      snapshot
                                                          .data!.glucoseTarget,
                                                      snapshot.data!.glucoseLow,
                                                      snapshot
                                                          .data!.hypoglycemia,
                                                      snapshot.data!
                                                          .hyperglycemiaAfterMeal,
                                                      snapshot.data!
                                                          .glucoseHighAfterMeal,
                                                      snapshot.data!
                                                          .glucoseLowAfterMeal,
                                                      snapshot.data!
                                                          .breakFastStartTime,
                                                      snapshot.data!
                                                          .breakFastEndTime,
                                                      snapshot
                                                          .data!.lunchStartTime,
                                                      snapshot
                                                          .data!.lunchEndTime,
                                                      snapshot.data!
                                                          .dinnerStartTime,
                                                      snapshot
                                                          .data!.dinnerEndTime,
                                                      result,
                                                      snapshot.data!
                                                          .carbohydratesRatio!);
                                            },
                                            title: const Text(
                                              "Insulin sensitibity (hourly)",
                                            ),
                                            subtitle: Text(
                                              'Glucose amount reduction in mmol/L per insulin unit ${(snapshot.data!.insulinSensitivity == -1) ? '' : '\n00:00->' + snapshot.data!.insulinSensitivity.toString()}',
                                            ),
                                          ),
                                          Divider(
                                            height: 20,
                                            thickness: 1.5,
                                            color: Colors.grey[600],
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                left: 50, top: 20),
                                            child: Text(
                                              'Breakfast time',
                                              style: TextStyle(
                                                  color: primaryColor,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          ListTile(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                              horizontal: 50,
                                            ),
                                            onTap: () async {
                                              await showInformationDialog(
                                                  "Please enter your first name",
                                                  "First Name",
                                                  childData.firstName);
                                            },
                                            title: const Text(
                                              "Breakfast start time",
                                            ),
                                            subtitle: Text(
                                              snapshot.data!.breakFastStartTime,
                                            ),
                                          ),
                                          ListTile(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                              horizontal: 50,
                                            ),
                                            onTap: () async {
                                              await showInformationDialog(
                                                  "Please enter your first name",
                                                  "First Name",
                                                  childData.firstName);
                                            },
                                            title: const Text(
                                              "Breakfast end time",
                                            ),
                                            subtitle: Text(
                                              snapshot.data!.breakFastEndTime,
                                            ),
                                          ),
                                          Divider(
                                            height: 20,
                                            thickness: 1.5,
                                            color: Colors.grey[600],
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                left: 50, top: 20),
                                            child: Text(
                                              'Lunch time',
                                              style: TextStyle(
                                                  color: primaryColor,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          ListTile(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                              horizontal: 50,
                                            ),
                                            onTap: () async {
                                              await showInformationDialog(
                                                  "Please enter your first name",
                                                  "First Name",
                                                  childData.firstName);
                                            },
                                            title: const Text(
                                              "Lunch start time",
                                            ),
                                            subtitle: Text(
                                              snapshot.data!.lunchStartTime,
                                            ),
                                          ),
                                          ListTile(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                              horizontal: 50,
                                            ),
                                            onTap: () async {
                                              await showInformationDialog(
                                                  "Please enter your first name",
                                                  "First Name",
                                                  childData.firstName);
                                            },
                                            title: const Text(
                                              "Lunch end time",
                                            ),
                                            subtitle: Text(
                                              snapshot.data!.lunchEndTime,
                                            ),
                                          ),
                                          Divider(
                                            height: 20,
                                            thickness: 1.5,
                                            color: Colors.grey[600],
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                left: 50, top: 20),
                                            child: Text(
                                              'Dinner time',
                                              style: TextStyle(
                                                  color: primaryColor,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          ListTile(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                              horizontal: 50,
                                            ),
                                            onTap: () async {
                                              await showInformationDialog(
                                                  "Please enter your first name",
                                                  "First Name",
                                                  childData.firstName);
                                            },
                                            title: const Text(
                                              "Dinner start time",
                                            ),
                                            subtitle: Text(
                                              snapshot.data!.dinnerStartTime,
                                            ),
                                          ),
                                          ListTile(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                              horizontal: 50,
                                            ),
                                            onTap: () async {
                                              await showInformationDialog(
                                                  "Please enter your first name",
                                                  "First Name",
                                                  childData.firstName);
                                            },
                                            title: const Text(
                                              "Dinner end time",
                                            ),
                                            subtitle: Text(
                                              snapshot.data!.dinnerEndTime,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : const Loading();
                            }),
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
