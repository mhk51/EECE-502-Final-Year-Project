import 'package:flutter/material.dart';

class SignUp1 extends StatefulWidget {
  const SignUp1({Key? key}) : super(key: key);

  @override
  State<SignUp1> createState() => _SignUp1State();
}

class _SignUp1State extends State<SignUp1> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: const Color.fromARGB(242, 242, 242, 242),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width,
                  // color: Color.fromARGB(255, 255, 255, 255),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Stack(children: [
                    Positioned(
                        left: 24,
                        top: 10,
                        child: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.arrow_back))),
                    const Positioned(
                      left: 24,
                      right: 122,
                      top: 75,
                      child: Text(
                        "What Should I Eat?", overflow: TextOverflow.visible,
                        textAlign: TextAlign.left,
                        // textScaleFactor: textScaleFactor,
                        style: TextStyle(
                          height: 0.8683594336876502,
                          fontSize: 65.0,
                          fontFamily: 'Inria Serif',
                          fontWeight: FontWeight.w400,
                          color: Colors.black,

                          /* letterSpacing: -1.95, */
                        ),
                      ),
                    ),
                    Positioned(
                      left: 220,
                      top: 30,
                      child: Image.asset("assets/images/carrot.png"),
                    ),
                    const Positioned(
                      left: 65,
                      right: 65,
                      bottom: 24,
                      child: Text(
                        "General Info", overflow: TextOverflow.visible,
                        textAlign: TextAlign.left,
                        // textScaleFactor: textScaleFactor,
                        style: TextStyle(
                          height: 0.8683594336876502,
                          fontSize: 48.0,
                          fontFamily: 'Inria Serif',
                          fontWeight: FontWeight.w400,
                          color: Colors.black,

                          /* letterSpacing: -1.95, */
                        ),
                      ),
                    ),
                  ]),
                ),
                Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 50, right: 50, top: 60),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'First Name',
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 50, right: 50, top: 50),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Family Name',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 40, top: 60),
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all<Size>(
                              const Size(314, 70)),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 255, 75, 58)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                        ),
                        child: const Text(
                          "Next",
                          // textScaleFactor: textScaleFactor,
                          overflow: TextOverflow.visible,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            height: 0.8683594336876502,
                            fontSize: 24.0,
                            fontFamily: 'Inria Serif',
                            fontWeight: FontWeight.w400,
                            color: Colors.white,

                            /* letterSpacing: -1.95, */
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          )),
    );
  }
}
