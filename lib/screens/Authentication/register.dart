// import 'package:flutter_application_1/services/auth.dart';
import 'package:flutter_application_1/custom/constants.dart';
import 'package:flutter_application_1/custom/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/Authentication/register1.dart';
import 'package:flutter_application_1/screens/Authentication/register2.dart';
import 'package:flutter_application_1/screens/Authentication/register3.dart';
import 'package:flutter_application_1/screens/Authentication/registration_class.dart';
import 'package:flutter_application_1/services/auth.dart';
import 'package:provider/provider.dart';
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
  // text field state

  int _bottomBarIndex = 0;

  void setProgressBar(int val) {
    setState(() {
      _bottomBarIndex = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => RegistrationClass(),
          ),
        ],
        builder: (context, child) {
          bool loading = Provider.of<RegistrationClass>(context).loading;
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
                            customStep: (index, color, _) =>
                                color == Colors.black
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
                    onPageChanged: ((value) {
                      setState(() {
                        _bottomBarIndex = value;
                      });
                    }),
                    // physics: const NeverScrollableScrollPhysics(),
                    controller: controller,
                    children: [
                      RegisterPage1(
                        controller: controller,
                        setProgressBar: setProgressBar,
                      ),
                      RegisterPage2(
                        controller: controller,
                        setProgressBar: setProgressBar,
                      ),
                      RegisterPage3(
                        controller: controller,
                        setProgressBar: setProgressBar,
                      ),
                    ],
                  ),
                );
        });
  }
}
