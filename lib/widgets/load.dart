
import 'package:flutter/material.dart';
import '../config/size_config.dart';
import '../config/style.dart';

class Load {
  static loadingDialog(dynamic context) async {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Container(
          color: Colors.white.withOpacity(0.2),
          child: Container(
              child: Image.asset(
                  "assets/icons/animation.gif"
              )),
        );
      },
    );
  }

  static Future<void> showMyDialog(dynamic context, String msg ,{String? title, bool? showCancel}) async {
    double hm=SizeConfig.heightMultiplier;
    double wm=SizeConfig.widthMultiplier;
    double tm=SizeConfig.textMultiplier;
    bool cancel;
    if(showCancel==null){
      cancel=false;
    }else{
      cancel=showCancel;
    }
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title:(title!=null)?Center(
            child: Text("$title",style: TextStyle(
                height: 1.2,
                fontFamily: 'ComfortaaRegular',
                fontWeight: FontWeight.bold,
                fontSize: tm*2.5
            ),),
          ):null,
          content: SingleChildScrollView(
            child: Center(
              child: Text("$msg",textAlign: TextAlign.center,style: TextStyle(
                height: 1.2,
                fontFamily: 'ComfortaaRegular',
                fontSize:tm*2,
              ),),
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actionsPadding: EdgeInsets.only(bottom: hm*2.5),
          actions: <Widget>[
            if(cancel)
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Container(
                  width: wm*18,
                  height: hm*4,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: Colors.grey[700]!)
                  ),
                  child: Center(
                    child: Text("Cancel",style: TextStyle(
                      height: 1.2,
                      fontFamily: 'ComfortaaRegular',
                      fontSize: tm*2,
                      color: Colors.black,
                    ),),
                  ),
                ),
              ),
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                width: wm*15,
                height: hm*4,
                color: AppStyle.primary,
                child: Center(
                  child: Text("Ok",style: TextStyle(
                      height: 1.2,
                      fontFamily: 'ComfortaaRegular',
                      fontSize: tm*2,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                  ),),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
