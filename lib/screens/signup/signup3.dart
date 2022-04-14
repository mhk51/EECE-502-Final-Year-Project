import 'package:flutter/material.dart';

class SignUp3 extends StatefulWidget {
  const SignUp3({Key? key}) : super(key: key);

  @override
  State<SignUp3> createState() => _SignUp3State();
}

class _SignUp3State extends State<SignUp3> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color.fromARGB(242, 242, 242, 242),
          body: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width,
                // color: Color.fromARGB(255, 255, 255, 255),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
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
                      "Register", overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
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
                        const EdgeInsets.only(left: 50, right: 50, top: 70),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Email',
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 50, right: 50, top: 55),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Password',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40, top: 100),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        minimumSize:
                            MaterialStateProperty.all<Size>(Size(314, 70)),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromARGB(255, 255, 75, 58)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                      child: const Text(
                        "Register",
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
          )),
    );
  }
}
