import 'package:flutter/material.dart';
import 'package:flutter_application_1/custom/loading.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_application_1/screens/wrapper.dart';
import 'package:flutter_application_1/services/auth.dart';
import 'package:flutter_application_1/services/database.dart';
import 'package:provider/provider.dart';

class NavDrawer extends StatelessWidget {
  NavDrawer({Key? key}) : super(key: key);

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);
    Color primaryColor = const Color.fromARGB(255, 255, 75, 58);
    Color backgroundColor = const Color.fromARGB(238, 238, 238, 238);

    String? pageRouteName = ModalRoute.of(context)?.settings.name;
    if (user == null) {
      return const Wrapper();
    }
    return StreamBuilder<Child?>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Child? childData = snapshot.data;
            return Drawer(
              backgroundColor: Colors.grey[800],
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: childData!.gender == 'male'
                              ? const AssetImage('assets/male.jpg')
                              : const AssetImage('assets/female.jpg'),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          ('${user.name}'),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 25),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(color: primaryColor),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.book,
                      color: Colors.white,
                      size: 28,
                    ),
                    title: const Text(
                      'Home',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    onTap: () =>
                        {Navigator.pushReplacementNamed(context, '/Home')},
                    tileColor: (pageRouteName == '/Home')
                        ? Colors.grey[700]
                        : Colors.grey[800],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.water_drop,
                      color: Colors.white,
                      size: 28,
                    ),
                    title: const Text(
                      'Bolus Advisor',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    onTap: () =>
                        {Navigator.pushReplacementNamed(context, '/Bolus')},
                    tileColor: (pageRouteName == '/Bolus')
                        ? Colors.grey[700]
                        : Colors.grey[800],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  // ListTile(
                  //   leading: const Icon(
                  //     Icons.insights_rounded,
                  //     color: Colors.white,
                  //     size: 28,
                  //   ),
                  //   title: const Text(
                  //     'Insights',
                  //     style: TextStyle(
                  //       color: Colors.white,
                  //       fontSize: 16,
                  //     ),
                  //   ),
                  //   onTap: () =>
                  //       {Navigator.pushReplacementNamed(context, '/Insights')},
                  //   tileColor: (pageRouteName == '/Insights')
                  //       ? Colors.grey[700]
                  //       : Colors.grey[800],
                  // ),
                  const SizedBox(
                    height: 8,
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.verified_user,
                      color: Colors.white,
                      size: 28,
                    ),
                    title: const Text(
                      'Daily Summary',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    onTap: () => {
                      Navigator.pushReplacementNamed(context, '/DailyLogging')
                    },
                    tileColor: (pageRouteName == '/DailyLogging')
                        ? Colors.grey[700]
                        : Colors.grey[800],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.restaurant,
                      color: Colors.white,
                      size: 28,
                    ),
                    title: const Text(
                      'Logging Food',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    onTap: () => {
                      Navigator.pushReplacementNamed(context, '/LoggingFood')
                    },
                    tileColor: (pageRouteName == '/LoggingFood')
                        ? Colors.grey[700]
                        : Colors.grey[800],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.settings,
                      color: Colors.white,
                      size: 28,
                    ),
                    title: const Text(
                      'Profile & Settings',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    onTap: () =>
                        {Navigator.pushReplacementNamed(context, '/Settings')},
                    tileColor: (pageRouteName == '/Settings')
                        ? Colors.grey[700]
                        : Colors.grey[800],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.exit_to_app,
                      color: Colors.white,
                      size: 28,
                    ),
                    title: const Text(
                      'Logout',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    onTap: () async {
                      await _auth.signOut();
                      await Navigator.pushReplacementNamed(context, '/');
                    },
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
