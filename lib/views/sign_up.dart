import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:save_password/config/size_config.dart';
import 'package:save_password/providers/auth_provider.dart';
import 'package:save_password/views/home_screen.dart';
class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var hm=SizeConfig.heightMultiplier;
    var wm=SizeConfig.widthMultiplier;
    var tm=SizeConfig.textMultiplier;
    var provider= context.read<AuthProvider>();
    var Dprovider=context.watch<AuthProvider>();
    return  StreamBuilder(
      stream:  FirebaseAuth.instance.authStateChanges(),
      builder: (context,snapshot) {
        if(snapshot.connectionState==ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(),);
        } else if(snapshot.hasError) {
          return const Center(child: Text('Something went wrong!'));
        }else if(snapshot.hasData) {
          return const HomeScreen();
         }else {
          return !Dprovider.isLoading? OutlinedButton.icon(
          icon: Image.asset("assets/icons/google.png",width: wm*7,),
          onPressed: () async {
           context.read<AuthProvider>().googleLogin();
          },
          label: const Text(
            "Sign in",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold),
          ),
          style: ButtonStyle(
              backgroundColor:
              MaterialStateProperty.all<Color>(Colors.grey),
              side: MaterialStateProperty.all<BorderSide>(BorderSide.none)),
        ) : const CircularProgressIndicator();
        }
        }
    );
  }
  }

