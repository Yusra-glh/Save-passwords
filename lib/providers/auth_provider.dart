import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:save_password/models/user.dart';
import 'package:save_password/services/sign_in_services.dart';
import 'package:save_password/widgets/Popup.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;
  bool isLoading = false;

  Future<bool> googleLogin(BuildContext context) async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return false;
      _user = googleUser;
      final googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      var auth = FirebaseAuth.instance.currentUser;
      print("auth data !!!!!!!!!!!!!");
      print(auth);
      if (auth != null) {
         var _token = await SharedPreferences.getInstance();
        _token.setString("token", auth.uid);
        await addUser(auth);
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      Popup(context, "Ok", title: "Error", description: e.toString());
      return false;
    }
    isLoading = false;
  }

  addUser(User? user) async {
    if (user != null) {
      final docUser = FirebaseFirestore.instance.collection("users");
      final newUser = UserModel(
          id: user.uid,
          email: user.email,
          name: user.displayName,
          image: user.photoURL);
      await docUser
          .doc(user.uid)
          .set(newUser.toJson())
          .whenComplete(() => print("complete"));
    }
  }

  Future<bool> googleLogout() async {
    var logout = await googleSignIn.disconnect();
    var authLogout = await FirebaseAuth.instance.signOut();
    notifyListeners();
    return true;
  }

  Future<bool> addPassword(String password) async {
    try {
      var auth = FirebaseAuth.instance.currentUser;
      if (auth != null) {
        await auth.updatePassword(password);
        if (await updateUser(auth, password)) {
          return true;
        }
        return false;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> updateUser(User? user, String? password) async {
    if (user != null) {
      final docUser = FirebaseFirestore.instance.collection("users");
      final newUser = UserModel(
          id: user.uid,
          email: user.email,
          name: user.displayName,
          image: user.photoURL,
          password: password);
      await docUser.doc(user.uid).update(newUser.toJson());
      return true;
    } else {
      return false;
    }
  }
}
