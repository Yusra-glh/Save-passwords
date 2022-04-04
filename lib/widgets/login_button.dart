import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:save_password/providers/auth_provider.dart';

class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
        padding: const EdgeInsets.only(top: 160),
        onPressed: (){
          context.read<AuthProvider>().googleLogin();
        },
        child: const Text(
          'Login',
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontWeight: FontWeight.w300,
              color: Colors.black,
              fontSize: 20,
              letterSpacing: 0.5
          ),
        )
    );
  }
}