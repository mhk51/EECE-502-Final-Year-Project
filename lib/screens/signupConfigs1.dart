// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';

class signupConfig1 extends StatelessWidget {
  const signupConfig1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      // ignore: prefer_const_literals_to_create_immutables
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        const Padding(
          padding: EdgeInsets.all(10),
          // ignore: unnecessary_const
          child: const Text(
            "Welcome to (AppName)",
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: const Text(
            "We need to know you better before getting started...",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const Text(
                "What is Your Name",
                style: TextStyle(fontSize: 20),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                // ignore: unnecessary_const
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: "Enter Full Name:",
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
                "What Do you want us to call you?",
                style: TextStyle(fontSize: 20),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: const TextField(
                  decoration: const InputDecoration(
                    hintText: "Enter UserName:",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.text,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    "Next",
                    style: TextStyle(fontSize: 20),
                  ),
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(size.width, 60)),
                ),
              )
            ],
          ),
        ),
      ]),
    ));
  }
}
