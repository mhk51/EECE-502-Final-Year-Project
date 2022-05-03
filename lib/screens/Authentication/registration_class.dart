import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_application_1/services/auth.dart';

enum SignUpScreen { signup1, signup2, signup3 }

class RegistrationClass extends ChangeNotifier {
  String email;
  String password;
  String confirmPassword;
  String username;
  String fullname;
  int age;
  int height;
  int weight;
  bool isGenderMale;
  String error;
  bool loading = false;
  SignUpScreen signUpScreen = SignUpScreen.signup1;
  final _auth = AuthService();
  RegistrationClass({
    this.email = "blabla",
    this.password = "",
    this.confirmPassword = "",
    this.fullname = "",
    this.username = "",
    this.age = 0,
    this.height = 0,
    this.weight = 0,
    this.isGenderMale = true,
    this.error = "",
  });
  void changeEmail(String val) {
    email = val;
    notifyListeners();
  }

  void changePassword(String val) {
    password = val;
    notifyListeners();
  }

  void changeConfirmPassword(String val) {
    confirmPassword = val;
    notifyListeners();
  }

  void changeFullname(String val) {
    fullname = val;
    notifyListeners();
  }

  void changeUsername(String val) {
    username = val;
    notifyListeners();
  }

  void changeAge(int val) {
    age = val;
    notifyListeners();
  }

  void changeHeight(int val) {
    height = val;
    notifyListeners();
  }

  void changeWeight(int val) {
    weight = val;
    notifyListeners();
  }

  void changeError(String val) {
    error = val;
    notifyListeners();
  }

  void setGender(bool val) {
    isGenderMale = val;
    notifyListeners();
  }

  void setLoading(bool val) {
    loading = val;
    notifyListeners();
  }

  void setSignUpScreen(SignUpScreen screen) {
    signUpScreen = screen;
    notifyListeners();
  }

  Future<CustomUser?> registerUser() async {
    return await _auth.registerWithEmailAndPassword(email, password, username);
  }
}
