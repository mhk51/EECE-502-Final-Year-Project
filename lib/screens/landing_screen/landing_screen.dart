import 'package:flutter/material.dart';

const mockupHeight = 896;
const mockupWidth = 414;

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final scale = mockupWidth / width;
    final textScaleFactor = width / mockupWidth.toDouble();
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 75, 58),
        body: Stack(children: [
          Positioned(
            left: 51,
            right: 95,
            top: 82,
            bottom: 641,
            child: Text(
              '''What Should I Eat?''',
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
          Positioned(
              left: 185,
              right: 24,
              top: 231,
              bottom: 471,
              child: Image.asset(
                "assets/images/buritto.png",
                height: 194,
                width: 205,
                scale: scale,
              )),
          Positioned(
              left: 12,
              right: 172.68,
              top: 328,
              bottom: 307.75,
              child: Image.asset(
                "assets/images/burger.png",
                height: 194,
                width: 205,
                scale: scale,
              )),
          Positioned(
              left: 87,
              right: 12.46,
              top: 394,
              bottom: 113.84,
              child: Image.asset(
                "assets/images/pizza.png",
                height: 194,
                width: 205,
                scale: scale,
              )),
          Positioned(
              left: 50,
              right: 50,
              // top: 747,
              bottom: 79,
              child: ElevatedButton(
                onPressed: () {},
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
              )),
          Positioned(
              left: 30,
              right: 30,
              // top: 747,
              bottom: 30,
              child: TextButton(
                onPressed: () {},
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
              )),
        ]),
      ),
    );
  }
}
