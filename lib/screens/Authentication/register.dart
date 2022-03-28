// import 'package:flutter_application_1/services/auth.dart';
import 'package:flutter_application_1/custom/constants.dart';
import 'package:flutter_application_1/custom/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_application_1/services/auth.dart';
import 'package:flutter_application_1/services/database.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  const Register({Key? key, required this.toggleView}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

enum SingingCharacter { lafayette, jefferson }

class _RegisterState extends State<Register>
    with SingleTickerProviderStateMixin {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  String confirmPass = '';
  String username = '';
  String fullname = '';
  String userUID = '';
  int age = 0;
  int height = 0;
  int weight = 0;
  int _bottomBarIndex = 0;
  bool isGenderMale = false;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final PageController controller = PageController();
    return loading
        ? const Loading()
        : Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.indigo[100],
            appBar: AppBar(
              backgroundColor: Colors.indigo[800],
              elevation: 0.0,
              title: const Text('Sign up'),
              actions: <Widget>[
                TextButton.icon(
                  icon: const Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  label: const Text(
                    'Sign In',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () => widget.toggleView(),
                  // style: TextButton.styleFrom(
                  //   primary: Colors.pink[400],
                  // ),
                ),
              ],
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(kToolbarHeight),
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                    child: StepProgressIndicator(
                      totalSteps: 3,
                      currentStep: _bottomBarIndex,
                      size: 36,
                      selectedColor: Colors.black,
                      unselectedColor: Colors.white,
                      customStep: (index, color, _) => color == Colors.black
                          ? Container(
                              color: color,
                              child: const Icon(
                                Icons.check,
                                color: Colors.white,
                              ),
                            )
                          : Container(
                              color: color,
                              child: const Icon(
                                Icons.remove,
                              ),
                            ),
                    )),
              ),
            ),
            body: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: controller,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 50.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 20.0),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                              hintText: 'Email...'),
                          validator: (val) =>
                              val!.isEmpty ? 'Enter an email' : null,
                          onChanged: (val) {
                            setState(() => email = val);
                          },
                        ),
                        const SizedBox(height: 20.0),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                              hintText: 'Password...'),
                          obscureText: true,
                          validator: (val) => val!.length < 6
                              ? 'Enter a password 6+ chars long'
                              : null,
                          onChanged: (val) {
                            setState(() => password = val);
                          },
                        ),
                        const SizedBox(height: 20.0),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                              hintText: 'Confirm Password...'),
                          obscureText: true,
                          validator: (val) => val != password
                              ? 'Enter a matching password'
                              : null,
                          onChanged: (val) {
                            setState(() => confirmPass = val);
                          },
                        ),
                        const SizedBox(height: 20.0),
                        ElevatedButton(
                          child: const Text(
                            'Register',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              // setState(() => loading = true);
                              // CustomUser? result =
                              //     await _auth.registerWithEmailAndPassword(
                              //         email, password, username);
                              // if (result == null) {
                              //   setState(() {
                              //     error = 'Please supply a valid email';
                              //   });
                              // }
                              controller.nextPage(
                                  duration: const Duration(seconds: 1),
                                  curve: Curves.decelerate);
                              setState(() {
                                _bottomBarIndex++;
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.pink[400],
                          ),
                        ),
                        const SizedBox(height: 12.0),
                        Text(
                          error,
                          style: const TextStyle(
                              color: Colors.red, fontSize: 14.0),
                        )
                      ],
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Welcome to (AppName)",
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "We need to know you better before getting started...",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          const Text(
                            "What is Your Name",
                            style: TextStyle(fontSize: 20),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              onChanged: (val) {
                                fullname = val;
                              },
                              decoration: const InputDecoration(
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
                        children: [
                          const Text(
                            "What Do you want us to call you?",
                            style: TextStyle(fontSize: 20),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              onChanged: (value) {
                                username = value;
                              },
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
                              onPressed: () async {
                                controller.nextPage(
                                    duration: const Duration(seconds: 1),
                                    curve: Curves.slowMiddle);
                                setState(() {
                                  _bottomBarIndex++;
                                });
                              },
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
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Hey $username!",
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isGenderMale = true;
                            });
                          },
                          child: const Text(
                            " Male ",
                            style: TextStyle(fontSize: 20),
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: isGenderMale ? Colors.red : Colors.blue),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isGenderMale = false;
                            });
                          },
                          child: const Text(
                            "Female",
                            style: TextStyle(fontSize: 20),
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: isGenderMale ? Colors.blue : Colors.red),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const Text(
                            "What is your age?",
                            style: TextStyle(fontSize: 20),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            // ignore: unnecessary_const
                            child: TextField(
                              onChanged: (value) {
                                age = int.parse(value);
                              },
                              decoration: const InputDecoration(
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
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          const Text(
                            "How tall are you?",
                            style: TextStyle(fontSize: 20),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              onChanged: (value) {
                                height = int.parse(value);
                              },
                              decoration: const InputDecoration(
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
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          const Text(
                            "How much do you weigh?",
                            style: TextStyle(fontSize: 20),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              onChanged: (value) {
                                weight = int.parse(value);
                              },
                              decoration: const InputDecoration(
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
                      padding: const EdgeInsets.all(10.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          // setState(() => loading = true);
                          CustomUser? result =
                              await _auth.registerWithEmailAndPassword(
                                  email, password, username);
                          if (result == null) {
                            controller.animateToPage(0,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.bounceIn);
                            setState(() {
                              loading = false;
                              error = 'Please supply a valid email';
                            });
                          } else {
                            await DatabaseService(uid: result.uid)
                                .updateUserDataCollection(
                              username,
                              email,
                              height,
                              age,
                              weight,
                              isGenderMale ? 'male' : 'female',
                            );
                          }
                        },
                        child: const Text(
                          "Submit",
                          style: TextStyle(fontSize: 20),
                        ),
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(size.width, 60)),
                      ),
                    )
                  ],
                ),
              ],
            ),
            // floatingActionButton: FloatingActionButton(
            //   onPressed: () {
            //     controller.nextPage(
            //         duration: Duration(seconds: 1), curve: Curves.ease);
            //   },
            // ),
          );
  }
}
