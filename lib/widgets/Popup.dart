
import 'package:flutter/material.dart';
import 'package:save_password/config/size_config.dart';
import 'package:save_password/config/style.dart';
import 'package:save_password/config/textStyle.dart';

import '../../../widgets/primary_button.dart';

Future<dynamic> Popup(BuildContext context, String confirmText,{String? title,String? description,Function? confirmFunction}) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (context,stating) {
              final hm = SizeConfig.heightMultiplier;
              final wm = SizeConfig.widthMultiplier;
              final tm = SizeConfig.textMultiplier;
              return Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(wm*5.0)), //this right here
                child: SizedBox(
                  height: hm*35,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      if(title != null)
                        Positioned(
                          top:hm*6,
                          child: Padding(
                            padding:  EdgeInsets.fromLTRB(
                                wm*2.5,
                                hm*1,
                                wm*2.5,
                                hm*3
                            ),
                            child: Container(
                              width: wm*60,
                              height: hm*10,
                              color: Colors.white,
                              child: Text(title,maxLines: 2,textAlign: TextAlign.center,style: tS('NunitoBold', tm*2.5, FontWeight.normal, Colors.black),),
                            ),
                          ),
                        ),
                      if(description != null)
                        Positioned(
                          child: Container(
                            margin: EdgeInsets.only(top: hm*2),
                            width: wm*60,
                            height: hm*10,
                            color: Colors.white,
                            child: Text(description,maxLines: 2,textAlign: TextAlign.center,style: tS('NunitoMedium', tm*2.2, FontWeight.normal, Colors.black),),
                          ),
                        ),

                      Positioned(
                        bottom: hm*4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            //if(isConfirm)
                            primaryButton(height: hm*5, width: wm*30,
                                borderRadius: BorderRadius.circular(wm*4),
                                border: Border.all(color: AppStyle.disabledGrey,width: wm*0.2),
                                color: Colors.white,
                                widget: FittedBox(
                                  child: Padding(
                                    padding:  EdgeInsets.symmetric(horizontal: wm*2),
                                    child: Text("Cancel",style: tS('NunitoBold', tm*2, FontWeight.normal, Colors.black),),
                                  ),
                                )),
                            SizedBox(width: wm*4,),
                            primaryButton(height: hm*5.0, width: wm*30,borderRadius: BorderRadius.circular(wm*4),widget: FittedBox(
                              child: Padding(
                                padding:  EdgeInsets.symmetric(horizontal: wm*2),
                                child: Text(confirmText,style: tS('NunitoBold', tm*2, FontWeight.normal, Colors.white),),
                              ),
                            ),function: (){
                              if(confirmFunction!=null){
                                confirmFunction();
                              }else{
                                Navigator.pop(context);
                              }
                            }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
        );
      });
}
