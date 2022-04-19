import 'package:flutter/material.dart';
import 'package:save_password/config/size_config.dart';
import 'package:save_password/config/textStyle.dart';
import 'package:save_password/models/account.dart';
import 'package:save_password/widgets/primary_button.dart';
import 'package:save_password/widgets/rounded_text_field.dart';

import '../widgets/level_indicator.dart';
class AccountDetails extends StatelessWidget {
  final Account account;
  const AccountDetails({Key? key,required this.account}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController passwordController = TextEditingController();
    var hm=SizeConfig.heightMultiplier;
    var wm=SizeConfig.widthMultiplier;
    var tm=SizeConfig.textMultiplier;
    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: hm*10),
        SizedBox(height:hm*6,width: wm*11,child: Image.asset(account.icon??"assets/icons/key.png",fit: BoxFit.fill,)),
        Container(
          width: 90.0,
          child: new Divider(color: Colors.green),
        ),
        SizedBox(height: 10.0),
        Text(
          account.title??"",
          style: TextStyle(color: Colors.white, fontSize: 45.0),
        ),
        SizedBox(height: 30.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(flex: 3, child: LevelIndicator(length: account.strength??0.2,)),
            Expanded(
                flex: 6,
                child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      account.strengthValue??"",
                      style: TextStyle(color: Colors.white),
                    ))),
          ],
        ),
      ],
    );

    final topContent = Stack(
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(left: 10.0),
            height: MediaQuery.of(context).size.height * 0.5,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image:  AssetImage("assets/icons/account_bg.jpg"),
              fit: BoxFit.cover,
             // colorFilter:  ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.dstATop),
            ),
          ),),
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          padding: EdgeInsets.all(40.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, .9)),
          child: Center(
            child: topContentText,
          ),
        ),
        Positioned(
          left: 8.0,
          top: 60.0,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
        )
      ],
    );

    final bottomContentText = roundedTextField(context,wm,hm,tm,passwordController,"Password");
    final readButton = Padding(
      padding:  EdgeInsets.symmetric(horizontal: wm*4),
      child: primaryButton(height: hm*5.5, borderRadius: BorderRadius.circular(wm*4),width: double.maxFinite, widget:
      Center(
        child: Text('Edit password',style: tS('NunitoRegular', tm*2.2, FontWeight.bold, Colors.white),),
      ),function: () async {

      }),
    );
    final bottomContent = Container(
      // height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      // color: Theme.of(context).primaryColor,
      padding: EdgeInsets.all(40.0),
      child: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: hm*4,),
            bottomContentText,
            SizedBox(height: hm*8,),
            readButton],
        ),
      ),
    );

    return Scaffold(
      body: Column(
        children: <Widget>[topContent, bottomContent],
      ),
    );
    ;
  }
}
