
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:save_password/config/size_config.dart';
import 'package:save_password/config/textStyle.dart';
import 'package:save_password/providers/auth_provider.dart';
import 'package:save_password/views/home_screen.dart';
import 'package:save_password/widgets/load.dart';
import 'package:save_password/widgets/primary_button.dart';
import '../widgets/rounded_text_field.dart';
class AddPassword extends StatefulWidget {
  const AddPassword({Key? key}) : super(key: key);

  @override
  State<AddPassword> createState() => _SignInState();
}

class _SignInState extends State<AddPassword> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
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
    return GestureDetector(
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
                              image: AssetImage('assets/icons/password_bg.jpg'),
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
                      Text('Password',style: tS('NunitoBold', tm*3, FontWeight.bold, Colors.black),),
                      SizedBox(height: hm*1.8,),
                      Text('Add password to continue',style: tS('NunitoRegular', tm*2.5, FontWeight.normal, Colors.black),),
                      Padding(
                        padding:  EdgeInsets.fromLTRB(wm*9,hm*1,wm*9,0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              SizedBox(height: hm*3,),
                              /** Login button**/
                              roundedTextField(context,wm,hm,tm,passwordController,"Password"),
                              SizedBox(height: hm*4,),
                              roundedTextField(context,wm,hm,tm,confirmPasswordController,"Confirm password",oldPassword:passwordController.value.text ),
                              SizedBox(height: hm*4,),
                              Padding(
                                padding:  EdgeInsets.symmetric(horizontal: wm*4),
                                child: primaryButton(height: hm*5.5, borderRadius: BorderRadius.circular(wm*4),width: double.maxFinite, widget:
                                Center(
                                  child: Text('Continue',style: tS('NunitoRegular', tm*2.2, FontWeight.bold, Colors.white),),
                                ),function: () async {
                                   if(_formKey.currentState!=null &&_formKey.currentState!.validate()){
                                    if(await provider.addPassword(passwordController.text)){
                                      Navigator.pushReplacement(context,  MaterialPageRoute(builder: (BuildContext context) => const HomeScreen()));
                                    }else{
                                      Load.showMyDialog(context, "An error has occurred please try again",title: "Error");
                                    }
                                   }
                                }),
                              ),
                              SizedBox(height: hm*2.2,),
                              /** End Login button**/
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
  }
}

