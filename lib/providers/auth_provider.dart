import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:save_password/services/sign_in_services.dart';

class AuthProvider with ChangeNotifier{
  final googleSignIn=GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;
  bool isLoading=false;
googleLogin() async {

  try {
    final googleUser=await googleSignIn.signIn();
    if(googleUser==null) return;
    _user=googleUser;
    final googleAuth=await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(credential);
    notifyListeners();
  //  Navigator.pushNamedAndRemoveUntil(context, Constants.homeNavigate, (route) => false);
  } catch(e){
    if(e is FirebaseAuthException){
     // showMessage(e.message!);
    }
  }

    isLoading = false;

}
}