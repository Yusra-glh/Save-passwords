import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:save_password/config/size_config.dart';
import 'package:save_password/providers/auth_provider.dart';
import 'package:save_password/views/home_screen.dart';
import 'package:save_password/widgets/login_button.dart';
import 'package:save_password/widgets/stagger_animation_login.dart';
class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> with SingleTickerProviderStateMixin{
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var hm=SizeConfig.heightMultiplier;
    var wm=SizeConfig.widthMultiplier;
    var tm=SizeConfig.textMultiplier;
    var provider= context.read<AuthProvider>();
    var Dprovider=context.watch<AuthProvider>();
    timeDilation = 1;
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
          return !Dprovider.isLoading? Scaffold(
            body: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/icons/login_bg.jpg"),
                      fit: BoxFit.fill)),
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Column(
                        children:  [
                          Padding(
                            padding: EdgeInsets.only(top: hm*6, bottom: hm*5),
                            child: Text("Save Passwords",style: TextStyle(fontWeight: FontWeight.bold,fontSize: tm*4,color: Colors.white),)
                          ),
                          SizedBox(height: hm*89,)
                        ],
                      ),
                      StaggerAnimationLogin(
                          controller:
                          _animationController // _animationController.view
                      )
                    ],
                  )
                ],
              ),
            ),
          ) : const CircularProgressIndicator();
        }
        }
    );
  }
}

