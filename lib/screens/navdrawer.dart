import 'package:flutter/material.dart';
import 'package:flutter_application_1/custom/loading.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_application_1/services/auth.dart';
import 'package:flutter_application_1/services/database.dart';
import 'package:provider/provider.dart';

class NavDrawer extends StatelessWidget {
  final AuthService _auth = AuthService();
  NavDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);
    String? pageRouteName = ModalRoute.of(context)?.settings.name;

    return StreamBuilder<Child?>(
        stream: DatabaseService(uid: user!.uid).userData,
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
                    decoration: BoxDecoration(
                      color: Colors.indigo[800],
                    ),
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.book,
                      color: Colors.white,
                    ),
                    title: const Text(
                      'Home',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onTap: () =>
                        {Navigator.pushReplacementNamed(context, '/Home')},
                    tileColor: (pageRouteName == '/Home')
                        ? Colors.grey[700]
                        : Colors.grey[800],
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.info,
                      color: Colors.white,
                    ),
                    title: const Text(
                      'Item Info',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onTap: () =>
                        {Navigator.pushReplacementNamed(context, '/ItemInfo')},
                    tileColor: (pageRouteName == '/ItemInfo')
                        ? Colors.grey[700]
                        : Colors.grey[800],
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.insights_rounded,
                      color: Colors.white,
                    ),
                    title: const Text(
                      'Insights',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onTap: () =>
                        {Navigator.pushReplacementNamed(context, '/Insights')},
                    tileColor: (pageRouteName == '/Insights')
                        ? Colors.grey[700]
                        : Colors.grey[800],
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.verified_user,
                      color: Colors.white,
                    ),
                    title: const Text(
                      'Daily Logging',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onTap: () => {
                      Navigator.pushReplacementNamed(context, '/DailyLogging')
                    },
                    tileColor: (pageRouteName == '/DailyLogging')
                        ? Colors.grey[700]
                        : Colors.grey[800],
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.restaurant_outlined,
                      color: Colors.white,
                    ),
                    title: const Text(
                      'Logging Food',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onTap: () => {
                      Navigator.pushReplacementNamed(context, '/LoggingFood')
                    },
                    tileColor: (pageRouteName == '/LoggingFood')
                        ? Colors.grey[700]
                        : Colors.grey[800],
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.settings,
                      color: Colors.white,
                    ),
                    title: const Text(
                      'Profile & Settings',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onTap: () =>
                        {Navigator.pushReplacementNamed(context, '/Settings')},
                    tileColor: (pageRouteName == '/Settings')
                        ? Colors.grey[700]
                        : Colors.grey[800],
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.exit_to_app,
                      color: Colors.white,
                    ),
                    title: const Text(
                      'Logout',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onTap: () async {
                      await _auth.signOut();
                      Navigator.pushReplacementNamed(context, '/');
                    },
                  ),
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
