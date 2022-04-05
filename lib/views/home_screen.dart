import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:save_password/config/size_config.dart';
import 'package:save_password/providers/auth_provider.dart';

import '../widgets/primary_button.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var hm=SizeConfig.heightMultiplier;
    var wm=SizeConfig.widthMultiplier;
    var tm=SizeConfig.textMultiplier;
    return
      Scaffold(body: Center(child:
     primaryButton(height: hm*5.5, borderRadius: BorderRadius.circular(wm*4),width: double.maxFinite, widget:Text("Logout"),function: () async {
      await context.read<AuthProvider>().googleLogout();
     })));
  }
}
