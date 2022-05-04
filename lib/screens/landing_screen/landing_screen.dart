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
                  width: size.width,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 0.123 * size.width, top: 0.032 * size.height),
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
                ),
                Container(
                  width: size.width,
                  height: size.height * 0.475,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        left: 0.5 * size.width,
                        child: Image.asset(
                          "assets/images/buritto.png",
                          height: 0.216 * size.height,
                          width: 0.495 * size.width,
                          // scale: scale,
                        ),
                      ),
                      Positioned(
                        top: 0.1 * size.height,
                        child: Image.asset(
                          "assets/images/burger.png",
                          height: 0.246 * size.height,
                          width: 0.512 * size.width,
                          // scale: scale,
                        ),
                      ),
                      Positioned(
                        top: 0.15 * size.height,
                        left: 0.3 * size.width,
                        child: Image.asset(
                          "assets/images/pizza.png",
                          height: 0.383 * size.height,
                          width: 0.683 * size.width,
                          // scale: scale,
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    toggleSignUp();
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
                    toggleSignIn();
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
