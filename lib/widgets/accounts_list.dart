import 'package:flutter/material.dart';
import 'package:save_password/config/size_config.dart';
import 'package:save_password/views/account_details.dart';
import '../models/account.dart';
import 'level_indicator.dart';

class AccountList extends StatelessWidget {
  final Account account;
  const AccountList({Key? key,required this.account}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var hm=SizeConfig.heightMultiplier;
    var wm=SizeConfig.widthMultiplier;
    var tm=SizeConfig.textMultiplier;
    return SizedBox(
     // height: hm*12,
      //width:  MediaQuery.of(context).size.width*0.8,
      child: ListTile(
        //tileColor: Colors.black.withOpacity(0.2),
        contentPadding:
        EdgeInsets.symmetric(horizontal: wm*2, vertical: wm*1.2),
        leading: Container(
          width: wm*9,
          height: wm*8,
          padding: EdgeInsets.only(right: wm*2),
          decoration:  const BoxDecoration(
              border:  Border(
                  right:  BorderSide(width: 1.0, color: Colors.black26))),
          child: Image.asset(account.icon??"assets/icons/key.png",),
        ),
        title: Text(
          account.title??"",
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),
        subtitle: Row(
          children: <Widget>[
            Expanded(
                flex: 2,
                child: LevelIndicator(length: account.strength??0.5,)),
            Expanded(
              flex: 4,
              child: Padding(
                  padding: EdgeInsets.only(left: wm*3),
                  child: Text(account.strengthValue??"medium",
                      style: const TextStyle(color: Colors.black54))),
            )
          ],
        ),
        trailing:
        Icon(Icons.keyboard_arrow_right, color: Colors.black, size: wm*4),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AccountDetails(account: account)));
        },
      ),
    );
  }
}
