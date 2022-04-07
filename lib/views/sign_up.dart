import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:save_password/config/size_config.dart';
import 'package:save_password/config/style.dart';
import 'package:save_password/config/textStyle.dart';
import 'package:save_password/providers/auth_provider.dart';
import 'package:save_password/views/add_password.dart';
import 'package:save_password/views/home_screen.dart';
import 'package:save_password/widgets/primary_button.dart';
class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> with SingleTickerProviderStateMixin{
  //late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    // _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    // _animationController.addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     Navigator.of(context).pushReplacement(
    //         MaterialPageRoute(builder: (context) => HomeScreen()));
    //   }
    // });
    var auth=FirebaseAuth.instance.currentUser;
    print("auth");
    print(auth?.uid);
  }

  @override
  void dispose() {
 //   _animationController.dispose();
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
          return const AddPassword();
         }else {
          return !Dprovider.isLoading?
          GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                toolbarHeight: hm* 50,
                elevation: 0,
                automaticallyImplyLeading: false,
                backgroundColor: Colors.white,
                flexibleSpace: Center(
                  child: Container(
                    width: double.maxFinite,
                    height: hm * 60,
                    margin: EdgeInsets.only(bottom: hm*3.5),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: wm * 0.5,
                            blurRadius: wm * 1,
                            offset: Offset(
                                wm * 0.0, hm * 0.5), // changes position of shadow
                          ),
                        ],
                        image: const DecorationImage(
                            image: AssetImage('assets/icons/login_bg.jpg'),
                            fit: BoxFit.fill),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(wm * 10),
                            bottomRight: Radius.circular(wm * 10))),
                  ),
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Text('Login',style: tS('NunitoBold', tm*3, FontWeight.bold, Colors.black),),
                    SizedBox(height: hm*1.8,),
                    Text('login to continue',style: tS('NunitoRegular', tm*2.5, FontWeight.normal, Colors.black),),
                    Padding(
                      padding:  EdgeInsets.fromLTRB(wm*9,hm*1,wm*9,0),
                      child: Form(
                        child: Column(
                          children: [
                            SizedBox(height: hm*3,),

                            SizedBox(height: hm*4,),
                            /** Login button**/
                            Padding(
                              padding:  EdgeInsets.symmetric(horizontal: wm*4),
                              child: primaryButton(height: hm*5.5, borderRadius: BorderRadius.circular(wm*4),width: double.maxFinite, widget:
                              Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: SizedBox(
                                        width: wm*7,
                                        height: wm*7,
                                        child: const Image(
                                          image: AssetImage('assets/icons/google.png',),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: wm*2,),
                                    Text('Login',style: tS('NunitoRegular', tm*2.2, FontWeight.bold, Colors.white),),
                                  ],
                                ),
                              ),function: () async {
                               if(await provider.googleLogin()){
                                 print("login!!!");
                               //  Navigator.pushReplacement(context,  MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
                               }
                              }),
                            ),
                            SizedBox(height: hm*2.2,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                    onTap: (){
                                    },
                                    child: Text('Forgot Password?',style: tS('NunitoRegular', tm*1.8, FontWeight.w400, AppStyle.primary,textDecoration: TextDecoration.underline))),
                              ],
                            ),
                            /** End Login button**/

                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ): const CircularProgressIndicator();
        }
        }
    );
  }
}

