import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import '../Helpers/sharedPrefs.dart';
import '../Models/user_model.dart';

class UserRepository {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<User?> createUserWithEmail(String email, String password) async {
    try {
      UserCredential result = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;
      if (user != null) {
        return user;
      } else {
        return null;
      }
    } on FirebaseAuthException catch (error) {
      var message = error.code.toString();
      switch (error.code) {
        case 'invalid-email:':
          message = 'Email is Invalid!';
          break;
        case 'email-already-in-use:':
          message =
              'The email address already exists.Please proceed to login Screen ';
          break;
        case 'wrong-password':
          message = 'Invalid password. Please enter correct password.';
          break;
      }
      throw Exception(message);
    }
  }

  Future<User?> loginWithEmail(String email, String password) async {
    try {
      UserCredential result = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;
      if (user != null) {
        return user;
      } else {
        return null;
      }
    } on FirebaseAuthException catch (error) {
      var message = 'An Error Occured';
      switch (error.code) {
        case 'user-disabled':
          message =
              'This user has been temporarily disabled, Contact Support for more information';
          break;
        case 'user-not-found':
          message =
              'The email address is not assocciated with a user.Try another Email up or Register with this email address ';
          break;
        case 'wrong-password':
          message = 'Invalid email or password. Please try again.';
          break;
      }
      throw Exception(message);
    }
  }

  Future isUserSignedIn() async {
    User? user = firebaseAuth.currentUser;
    return user != null && user.uid.isEmpty;
  }

  Future logOut() async {
    try {
      await firebaseAuth.signOut();
    } catch (error) {
      throw Exception(error);
    }
  }

  Future resetPassword(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
    } on PlatformException catch (error) {
      throw Exception(error);
    }
  }

  Future<AppUser?> fetchCurrentUser() async {
    try {
      var userJson = await SharedPreferenceHelper().getcurrentUser();
      if (userJson != null) {
        AppUser currentUser = AppUser.fromJson(json.decode(userJson));
        return currentUser;
      }
      return null;
    } on PlatformException catch (error) {
      throw Exception(error);
    }
  }
}
