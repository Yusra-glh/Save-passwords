import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:save_password/config/size_config.dart';
import 'package:save_password/providers/account_provider.dart';
import 'package:save_password/widgets/primary_button.dart';

import '../config/textStyle.dart';
import '../models/account.dart';
import '../widgets/text_field.dart';
class NewAccount extends StatelessWidget {
   NewAccount({Key? key}) : super(key: key);
  TextEditingController emailController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var provider=context.read<AccountProvider>();
    var Dprovider=context.watch<AccountProvider>();
    final hm = SizeConfig.heightMultiplier;
    final wm = SizeConfig.widthMultiplier;
    final tm = SizeConfig.textMultiplier;
    return  Scaffold(
      appBar: AppBar(
        toolbarHeight: hm* 40,
        elevation: 0,
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white,
        flexibleSpace: Center(
          child: Container(
            width: double.maxFinite,
            height: hm * 40,
            margin: EdgeInsets.only(bottom: hm*0),
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
                    image: AssetImage('assets/icons/add_account.jpg'),
                    fit: BoxFit.fill),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(wm * 10),
                    bottomRight: Radius.circular(wm * 10))),
          ),
        ),
      ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(wm * 9,  wm * 5, wm * 9, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Add account",style: tS("NunitoBold", tm*3.2, FontWeight.normal, Colors.black),),
                    SizedBox(height: hm*5,),
                    TextFormField(
                      controller: titleController,
                      style:
                      tS('NunitoRegular', tm * 2, FontWeight.normal, Colors.black),
                      onChanged: (val) {
                        provider.setAccount(val);
                      },
                      decoration: InputDecoration(
                        prefixIcon: titleController.value.text!=null?Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SizedBox(height:hm*3,width: hm*2,child: Image.asset(provider.getIcon(titleController.value.text),height:hm*3,width: hm*2,fit: BoxFit.fill,)),
                        ):Padding(
                          padding: const EdgeInsets.all(10),
                          child: SizedBox(height:hm*3,width: hm*2,child: Image.asset('assets/icons/key.png',height:hm*3,width: hm*2,fit: BoxFit.fill,)),
                        ),
                        hintText: "Title",
                        hintStyle:
                        tS('NunitoRegular', tm * 2, FontWeight.normal, Colors.black.withOpacity(0.24)),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.black.withOpacity(0.24), width: wm * 0.4),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.black.withOpacity(0.24), width: wm * 0.4),
                        ),
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.red, width: wm * 0.4),
                        ),
                        focusedErrorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.red, width: wm * 0.4),
                        ),
                        errorStyle: tS('NunitoRegular', tm * 2, FontWeight.normal, Colors.red),
                      ),
                    ),
                    SizedBox(height: hm*2,),
                    textFormField( hm, wm, tm, "Email",emailController),
                    SizedBox(height: hm*2,),
                    textFormField( hm, wm, tm, "Password",passwordController),
                    SizedBox(height: hm*5,),
                    primaryButton(height: hm*5.5, width: wm*50, borderRadius: BorderRadius.circular(wm*4),widget: Text("Create",style: tS('NunitoBold', tm*2.2, FontWeight.normal, Colors.white),),function: () async {
                     Account model = Account(title: titleController.text.trim(),email: emailController.text.trim(),password: passwordController.text.trim());
                      if(await context.read<AccountProvider>().addNewAccount(model)){
                        Navigator.pop(context);
                      }
                    })
                  ],
                ),
              ),
            ],
          ),
        ),
      );
  }
}
