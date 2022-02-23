// ignore_for_file: avoid_print

import 'package:flutter_application_1/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebase user
  CustomUser? _userFromFirebaseUser(User? user) {
    if (user != null) {
      return CustomUser(
        uid: user.uid,
        name: user.displayName,
        email: user.email,
      );
    } else {
      return null;
    }
  }

  // auth change user stream
  Stream<CustomUser?> get user {
    // _auth.userChanges()
    //.map((FirebaseUser user) => _userFromFirebaseUser(user));
    return _auth.userChanges().map(_userFromFirebaseUser);
  }

  // sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  //update User display name
  Future<User?> updateDisplayName(String username) async {
    User? user = _auth.currentUser;
    await user!.updateDisplayName(username);
    await user.reload();
    return user;
  }

  // register with email and password
  Future registerWithEmailAndPassword(
      String email, String password, String username) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      // if (!user!.emailVerified) {
      //   await user.sendEmailVerification();
      // }
      // _auth.
      await DatabaseService(uid: user!.uid)
          .updateUserDataCollection(username, email, 0, 0, 0, 'male');
      // create a new document for the user with the uid
      // await DatabaseService(uid: user!.uid)
      //     .updateUserData('0', 'new crew member', 100);
      user = await updateDisplayName(username);
      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future resetPassowrd() async {
    User? user = _auth.currentUser;
    await _auth.sendPasswordResetEmail(email: user!.email!);
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
