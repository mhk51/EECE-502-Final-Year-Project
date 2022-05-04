import 'package:flutter/material.dart';
import 'package:flutter_application_1/custom/constants.dart';
import 'package:flutter_application_1/custom/loading.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_application_1/screens/settings/gender_dialog.dart';
import 'package:flutter_application_1/screens/settings/information_dialogs.dart';
import 'package:flutter_application_1/services/auth.dart';
import 'package:flutter_application_1/services/database.dart';
import 'package:provider/provider.dart';

class PersonalTab extends StatefulWidget {
  const PersonalTab({Key? key}) : super(key: key);

  @override
  State<PersonalTab> createState() => _PersonalTabState();
}

class _PersonalTabState extends State<PersonalTab> {
  final _auth = AuthService();

  Future<void> showResetInformationDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: Text(
                "A link has been sent to your email to reset the password,\nPlease check all your inboxes.",
                style: TextStyle(
                  fontSize: 22,
                  fontFamily: 'Inria Serif',
                )),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);
    return user == null
        ? const Loading()
        : StreamBuilder<Child>(
            stream: DatabaseService(uid: user.uid).userData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active &&
                  snapshot.hasData) {
                Child childData = snapshot.data!;
                return Padding(
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
                              backgroundImage: childData.gender == 'male'
                                  ? const AssetImage('assets/male.jpg')
                                  : const AssetImage('assets/female.jpg'),
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
                                  border:
                                      Border.all(width: 2, color: Colors.white),
                                  borderRadius: BorderRadius.circular(90.0),
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
                        title: Text(
                          "Display Name",
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        subtitle: Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: Text(
                            childData.name!,
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
                          String result = await showInformationDialog(
                              context,
                              "Please enter your first name",
                              "First Name",
                              childData.firstName);
                          await DatabaseService(uid: childData.uid)
                              .updateUserDataCollection({'firstname': result});
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
                          String result = await showInformationDialog(
                              context,
                              "Please enter your last name",
                              "Last Name",
                              childData.lastName);
                          await DatabaseService(uid: childData.uid)
                              .updateUserDataCollection({'lastname': result});
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
                          String? result =
                              await showGenderDialog(context, childData.gender);
                          if (result != null) {
                            await DatabaseService(uid: childData.uid)
                                .updateUserDataCollection({'gender': result});
                          }
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
                          //
                          //
                          await showResetInformationDialog(context);
                          //
                          //
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
                );
              } else {
                return const Loading();
              }
            });
  }
}
