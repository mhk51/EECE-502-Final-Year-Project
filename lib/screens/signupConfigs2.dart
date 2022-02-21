// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class signupConfigs2 extends StatelessWidget {
  const signupConfigs2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                // ignore: prefer_const_constructors
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  // ignore: prefer_const_constructors
                  child: Text(
                    "Hey (USRNAME)!",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "You are almost Done...",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Just fill the information below and you are ready to go!",
                    style: TextStyle(fontSize: 20),
                  ),
                )
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    " Male ",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    "Female",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Text(
                    "What is your age?",
                    style: TextStyle(fontSize: 20),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    // ignore: unnecessary_const
                    child: const TextField(
                      decoration: InputDecoration(
                        hintText: "Enter Age:",
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.text,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Text(
                    "How tall are you?",
                    style: TextStyle(fontSize: 20),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    // ignore: unnecessary_const
                    child: const TextField(
                      decoration: InputDecoration(
                        hintText: "Enter height:",
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.text,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Text(
                    "How much do you weigh?",
                    style: TextStyle(fontSize: 20),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    // ignore: unnecessary_const
                    child: const TextField(
                      decoration: InputDecoration(
                        hintText: "Enter weight:",
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.text,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: () {},
                child: const Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 20),
                ),
                style:
                    ElevatedButton.styleFrom(minimumSize: Size(size.width, 60)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
