import 'package:flutter/material.dart';

const mockupHeight = 896;
const mockupWidth = 414;

class LandingScreen extends StatelessWidget {
  final Function toggleSignIn;
  final Function toggleSignUp;
  const LandingScreen(
      {Key? key, required this.toggleSignIn, required this.toggleSignUp})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final size = MediaQuery.of(context).size;
    final scale = mockupWidth / width;
    final textScaleFactor = width / mockupWidth.toDouble();
    print(scale);
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 75, 58),
        body: SingleChildScrollView(
          child: Column(
              //
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 0.05 * size.height,
                ),
                Container(
                  padding: EdgeInsets.only(left: 0.04 * size.width),
                  child: Text(
                    '''What\nShould I\nEat?''',
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.left,
                    textScaleFactor: textScaleFactor,
                    style: const TextStyle(
                      height: 0.8683594336876502,
                      fontSize: 65.0,
                      fontFamily: 'Inria Serif',
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(255, 255, 255, 255),

                      /* letterSpacing: -1.95, */
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 0.04 * size.width),
                  child: Image.asset(
                    "assets/images/buritto.png",
                    height: 194,
                    width: 205,
                    // scale: scale,
                  ),
                ),
                Image.asset(
                  "assets/images/burger.png",
                  height: 194,
                  width: 205,
                  // scale: scale,
                ),
                Image.asset(
                  "assets/images/pizza.png",
                  height: 194,
                  width: 205,
                  // scale: scale,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/Signup1');
                  },
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all<Size>(Size(314, 70)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                  child: Text(
                    "Get Started",
                    textScaleFactor: textScaleFactor,
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      height: 0.8683594336876502,
                      fontSize: 24.0,
                      fontFamily: 'Inria Serif',
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(255, 255, 75, 58),

                      /* letterSpacing: -1.95, */
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/SignIn");
                  },
                  child: Text(
                    "Already have an Account? Log In Here",
                    textScaleFactor: textScaleFactor,
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      height: 0.8683594336876502,
                      fontSize: 18.0,
                      fontFamily: 'Inria Serif',
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(255, 255, 255, 255),

                      /* letterSpacing: -1.95, */
                    ),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
