import 'package:flutter/material.dart';
import 'package:save_password/views/home_screen.dart';
import 'package:save_password/views/sign_up.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Wrapper extends StatefulWidget {
  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
   SharedPreferences? prefs;
  @override
  void initState() {
    super.initState();
    checkIsLogin();
  }

  Future<void> checkIsLogin() async {
    // Load.LoadingDialog(context);
    var _token = await SharedPreferences.getInstance();

    setState(() {
      prefs = _token;
    });
    print("prefs.getString()");
    print(prefs!.getString("token"));
  }

  @override
  Widget build(BuildContext context) {
    return prefs == null
        ? Container(
            color: Colors.white,
            child: Image.asset('assets/icons/password.gif'),
          )
        : prefs != null &&
                prefs!.getString("token") != null &&
                prefs!.getString("token") != ""
            ? HomeScreen()
            : SignIn();
  }
}
