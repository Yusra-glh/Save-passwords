import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:save_password/models/user.dart';
import 'package:save_password/services/sign_in_services.dart';

class AuthProvider with ChangeNotifier{
  final googleSignIn=GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;
  bool isLoading=false;
Future<bool> googleLogin() async {
  try {
    final googleUser=await googleSignIn.signIn();
    if(googleUser==null) return false;
    _user=googleUser;
    final googleAuth=await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(credential);
    var auth=FirebaseAuth.instance.currentUser;
    // print("auth data !!!!!!!!!!!!!");
    // print(auth);
    await addUser(auth);
    notifyListeners();
    return true;
  } catch(e){
    if(e is FirebaseAuthException){
     // showMessage(e.message!);
    }
    return false;
  }
    isLoading = false;
}
addUser(User? user) async {
  if(user!=null && user.uid!=null){
    final docUser=FirebaseFirestore.instance.collection("users");
    final newUser=UserModel(id: user.uid,email: user.email,name: user.displayName,image: user.photoURL);
    await docUser.doc(user.uid).set(newUser.toJson()).whenComplete(() => print("complete"));
  }
}

Future<bool> googleLogout() async {
 var logout= await googleSignIn.disconnect();
 var authLogout=await FirebaseAuth.instance.signOut();
 notifyListeners();
 return true;
}
}